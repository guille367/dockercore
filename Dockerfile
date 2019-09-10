FROM microsoft/dotnet:2.2-aspnetcore-runtime AS base
RUN mkdir /usr/local/argenper

WORKDIR /usr/local/argenper/app
EXPOSE 80

FROM microsoft/dotnet:2.2-sdk AS build
WORKDIR /usr/local/argenper

COPY ["/01 - Presentation/Presentation.csproj", "./Presentation/"]
COPY ["/02 - Services/Services.Interfaces/Services.Interfaces.csproj", "./02 - Services/Services/Services.Interfaces/"]
COPY ["/02 - Services/Services.Impl/Services.Impl.csproj", "./02 - Services/Services/Services.Impl/"]

RUN dotnet restore "./Presentation/Presentation.csproj"
COPY . ./

RUN dotnet build "./Presentation/Presentation.csproj" -c Release -o /usr/local/argenper/app
FROM build AS publish

WORKDIR /usr/local/argenper/app
RUN dotnet publish "./Presentation/Presentation.csproj" -c Release -o /usr/local/argenper/app
FROM base AS final
WORKDIR /app
COPY --from=publish /usr/local/argenper/app .
RUN ls
ENTRYPOINT ["dotnet", "Presentation.dll"]