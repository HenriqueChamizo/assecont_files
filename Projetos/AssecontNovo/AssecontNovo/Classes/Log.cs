using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;

namespace AssecontNovo.Classes
{
    public class Log
    {
        private List<string> Rows;
        private string Path;
        public Log(List<string> rows, string path = "")
        {
            Rows = rows;
            if (string.IsNullOrEmpty(path))
                Path = AppDomain.CurrentDomain.BaseDirectory.ToString();
            else
                Path = path;
        }

        public void CreateLog(string Name = "")
        {
            try
            {
                Path = Path + "\\Log\\";
                Directory.CreateDirectory(Path);
                if (string.IsNullOrEmpty(Name))
                    Name = "Log-" + DateTime.Now.ToString("yyyyMMddhhmm") + ".txt";
                StreamWriter FileLog = new StreamWriter(Path + Name, true, Encoding.Unicode);

                foreach (string row in Rows)
                {
                    FileLog.Write(row + "\r\n");
                    FileLog.Flush();
                }
                FileLog.Close();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
    }
}