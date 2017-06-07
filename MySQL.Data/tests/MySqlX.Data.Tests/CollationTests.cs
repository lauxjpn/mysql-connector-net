﻿// Copyright © 2017, Oracle and/or its affiliates. All rights reserved.
//
// MySQL Connector/NET is licensed under the terms of the GPLv2
// <http://www.gnu.org/licenses/old-licenses/gpl-2.0.html>, like most 
// MySQL Connectors. There are special exceptions to the terms and 
// conditions of the GPLv2 as it is applied to this software, see the 
// FLOSS License Exception
// <http://www.mysql.com/about/legal/licensing/foss-exception.html>.
//
// This program is free software; you can redistribute it and/or modify 
// it under the terms of the GNU General Public License as published 
// by the Free Software Foundation; version 2 of the License.
//
// This program is distributed in the hope that it will be useful, but 
// WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY 
// or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License 
// for more details.
//
// You should have received a copy of the GNU General Public License along 
// with this program; if not, write to the Free Software Foundation, Inc., 
// 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA

using MySql.Data.Common;
using MySql.Data.MySqlClient;
using MySqlX.XDevAPI;
using MySqlX.XDevAPI.Relational;
using System;
using System.Collections.Generic;
using Xunit;

namespace MySqlX.Data.Tests
{
  public class CollationTests : BaseTest
  {
    private static DBVersion _serverVersion;

    static CollationTests()
    {
      using (var connection = new MySqlConnection(ConnectionStringRoot))
      {
        connection.Open();
        _serverVersion = connection.driver.Version;
      }
    }

    /// <summary>
    /// Bug #26163694 SELECT WITH/WO PARAMS(DIFF COMB) N PROC CALL FAIL WITH KEY NOT FOUND EX-WL#10561
    /// </summary>
    [Fact]
    public void UTF8MB4DefaultCharsetExists()
    {
      if (!_serverVersion.isAtLeast(8,0,1)) return;

      using (Session session = MySQLX.GetSession(ConnectionString))
      {
        // Search database.
        var result = session.SQL("SHOW COLLATION WHERE id = 255").Execute();
        Assert.True(result.HasData);
        var data = result.FetchOne();
        Assert.Equal("utf8mb4_0900_ai_ci",data.GetString("Collation"));

        // Check in CollationMap.
        Assert.Equal("utf8mb4_0900_ai_ci", CollationMap.GetCollationName(255));
      }
    }
  }
}
