IF NOT "%1" == ""  SET MYSQL_PORT=%1

cd MySql.Data\tests\MySql.Data.Tests
dotnet restore MySql.Data.Tests.csproj
copy certificates\*.* %MYSQL_DATADIR%\
dotnet xunit -framework net452 -parallel none -xml n452-test-results.xml
dotnet xunit -framework netcoreapp1.1 -parallel none -xml netcore-test-results.xml

cd ..\MySqlX.Data.Tests
dotnet restore MySqlx.Data.Tests.csproj
dotnet xunit -framework net452 -parallel none -xml n452-test-results.xml
dotnet xunit -framework netcoreapp1.1 -parallel none -xml netcore-test-results.xml

REM ================== Register a verification exception ================================
REM sn.exe -Rca  ..\src\bin\debug\net452\MySql.Data.dll ConnectorNet
REM sn.exe -Rca bin\debug\net452\MySql.Data.Tests.dll ConnectorNet

REM =================== Test MySql.Data ==================================================
REM dotnet xunit -framework net452 -parallel none -xml n452-test-results.xml
REM dotnet xunit -framework netcoreapp1.1 -parallel none -xml netcore-test-results.xml
cd ../../..

REM =================== Test EF Core =====================================================
cd EntityFrameworkCore/tests/MySql.EntityFrameworkCore.Basic.Tests
dotnet restore
dotnet xunit -framework net452 -xml net452-test-results.xml
dotnet xunit -framework netcoreapp1.1 -xml netcore-test-results.xml

cd ../MySql.EntityFrameworkCore.Design.Tests/
dotnet restore
dotnet xunit -framework net452 -xml net452-test-results.xml
dotnet xunit -framework netcoreapp1.1 -xml netcore-test-results.xml

cd ../MySql.EntityFrameworkCore.Migrations.Tests
dotnet restore
dotnet xunit -framework net452 -xml net452-test-results.xml
dotnet xunit -framework netcoreapp1.1 -xml netcore-test-results.xml

cd ../../..

REM =================== Test EF 6 =====================================================
cd EntityFramework6/tests/MySql.EntityFramework6.Basic.Tests
dotnet restore
dotnet xunit -xml net452-test-results.xml