﻿using System;
using System.Data;
using System.Data.OleDb;

namespace Asseponto.Classes
{
    public class Excel
    {
        private string FilePath;
        private string Extension;
        private string isHDR;

        public Excel(string FilePath, string Extension, string isHDR)
        {
            this.FilePath = FilePath;
            this.Extension = Extension;
            this.isHDR = isHDR;
        }

        public DataTable getDataTable()
        {
            string conStr = "";
            switch (Extension)
            {
                case ".xls": //Excel 97-03
                    //conStr = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source={0};Extended Properties='Excel 8.0;HDR={1}'"; 
                    //conStr = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source={0};Extensão Propriedades='Excel 8.0 Xml;HDR={1};'";
                    conStr = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source={0};Extended Properties='Excel 12.0 Xml;HDR={1};ReadOnly=False';";
                    break;
                case ".xlsx": //Excel 07
                    conStr = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source={0};Extended Properties='Excel 8.0;HDR={1}'";
                    break;
            }

            conStr = String.Format(conStr, FilePath, isHDR);
            OleDbConnection connExcel = new OleDbConnection(conStr);
            OleDbCommand cmdExcel = new OleDbCommand();
            OleDbDataAdapter oda = new OleDbDataAdapter();
            DataTable dt = new DataTable();
            cmdExcel.Connection = connExcel;

            //Get the name of First Sheet
            connExcel.Open();
            DataTable dtExcelSchema;
            dtExcelSchema = connExcel.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);
            string SheetName = dtExcelSchema.Rows[0]["TABLE_NAME"].ToString();
            connExcel.Close();

            //Read Data from First Sheet
            connExcel.Open();
            cmdExcel.CommandText = "SELECT * From [" + SheetName + "]";
            oda.SelectCommand = cmdExcel;
            oda.Fill(dt);

            connExcel.Close();

            return dt;
        }
    }
}