#!/bin/bash

cd MySQL.Data
dotnet restore
dotnet build src/MySql.Data.csproj -c Release -f netstandard1.6

cd ../EntityFrameworkCore
dotnet restore
dotnet build src/MySql.Data.EntityFrameworkCore/MySql.Data.EntityFrameworkCore.csproj -c Release -f netstandard1.6
dotnet build src/MySql.Data.EntityFrameworkCore/MySql.Data.EntityFrameworkCore.csproj -c Release -f netstandard1.6


