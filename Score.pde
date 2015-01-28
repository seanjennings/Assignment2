Table table;

class Score
{
  //Sort(by score) and Save Tables
  void tableUpdate()
  {
    table = loadTable("table.csv", "header");
  
    for (TableRow row : table.rows())
    {
      float score = row.getInt("score");
    }
    
    table.sortReverse(int("score"));  
    saveTable(table, "data/table.csv");
  }
  
  //Add new entries to tables and call for updates
  void tableAdd(int score)
  {
    table = loadTable("table.csv", "header");
    
    TableRow newRow = table.addRow();
    newRow.setInt("score", score);
    saveTable(table, "data/table.csv");
    
    tableUpdate();
  }
  
  //Test if a score passed in is a high score
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
  
  //Retreive Top 5 scores
  int[] getScores()
  {
    table = loadTable("table.csv", "header");
    int top[] = new int[5];
    
    int i=0;
    for (TableRow row : table.rows())
    {
      float score = row.getFloat("score");
      top[i] = (int)score;
      i++;
      if(i>4)
      {
        break;
      }
    }
    return top;
  }
}
