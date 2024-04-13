FROM mcr.microsoft.com/dotnet/sdk:6.0-alpine AS builder
WORKDIR /app
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
COPY . .

RUN dotnet build "dotnetproject/dotnetproject.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "dotnetproject/dotnetproject.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "dotnetproject.dll"]