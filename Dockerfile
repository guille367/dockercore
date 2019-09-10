FROM node:10-alpine AS build-node
WORKDIR /app

COPY ./01.Presentation/ClientApp/package.json ./
COPY ./01.Presentation/ClientApp/package-lock.json ./

RUN npm install
COPY 01.Presentation/ClientApp ./

# FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS build-env
# WORKDIR /app
# COPY ./ ./

# RUN dotnet publish ./01.Presentation/Presentation.csproj -c Release -o out

# FROM mcr.microsoft.com/dotnet/core/aspnet:2.2
# WORKDIR /app
# RUN mkdir -p out
# COPY --from=build-env /app/out .

# ENTRYPOINT ["dotnet", "Presentation.dll"]