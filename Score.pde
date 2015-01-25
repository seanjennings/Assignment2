Table table;

class Score
{
  //Sort(by score) and Save Tables
  void tableUpdate()
  {
    table = loadTable("table.csv", "header");
  
    for (TableRow row : table.rows())
    {
      String name = row.getString("name");
      float score = row.getFloat("score");
    }
    
    table.sort("score");  
    saveTable(table, "data/table.csv");
  }
  
  //Add new entries to tables and call for updates
  void table_add(String name, Float score)
  {
    table = loadTable("table.csv", "header");
    
    TableRow newRow = table.addRow();
    newRow.setString("name", name);
    newRow.setFloat("score", score);
    saveTable(table, "data/table.csv");
    
    tableUpdate();
  }
  
  boolean checkTop(int test)
  {
    table = loadTable("table.csv", "header");
    
    int i=0;
    for (TableRow row : table.rows())
    {
      float score = row.getFloat("score");
      if(test > score)
      {
        return true;
      }
      i++;
      if(i>5)
      {
        break;
      }
    }
    return false;
  }
}
