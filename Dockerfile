FROM mcr.microsoft.com/dotnet/core/aspnet:3.1-buster-slim AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443
RUN curl -sL https://deb.nodesource.com/setup_12.x |  bash -
RUN apt-get install -y nodejs

FROM mcr.microsoft.com/dotnet/core/sdk:3.1-buster AS build
RUN curl -sL https://deb.nodesource.com/setup_12.x |  bash -
RUN apt-get install -y nodejs
WORKDIR /src
COPY ["DotnetTemplate.Web/DotnetTemplate.Web.csproj", "DotnetTemplate.Web/"]
RUN dotnet restore "DotnetTemplate.Web/DotnetTemplate.Web.csproj"
COPY . .
WORKDIR "/src/DotnetTemplate.Web"
RUN dotnet build "DotnetTemplate.Web.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "DotnetTemplate.Web.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "DotnetTemplate.Web.dll"]