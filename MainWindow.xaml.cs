using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using Microsoft.Win32;
using Excel = Microsoft.Office.Interop.Excel;

namespace HW10
{
    public partial class MainWindow : Window
    {
        Dictionary<string, int> itemUnits = new Dictionary<string, int>();
        Dictionary<string, double> itemRevenue = new Dictionary<string, double>();
        Dictionary<string, int> repUnits = new Dictionary<string, int>();
        Dictionary<string, double> repRevenue = new Dictionary<string, double>();
        Dictionary<string, int> regionUnits = new Dictionary<string, int>();
        Dictionary<string, double> regionRevenue = new Dictionary<string, double>();

        bool fileLoaded = false;

        public MainWindow()
        {
            InitializeComponent();
        }

        private void Menu_Open_Click(object sender, RoutedEventArgs e)
        {
            OpenFileDialog openFileDialog = new OpenFileDialog
            {
                Filter = "Excel Files|*.xls;*.xlsx;*.xlsm",
                Title = "Select an Excel File"
            };

            if (openFileDialog.ShowDialog() == true)
            {
                Excel.Application myApp = null;
                Excel.Workbook myBook = null;
                Excel.Worksheet mySheet = null;
                Excel.Range myRange = null;

                try
                {
                    itemUnits.Clear(); itemRevenue.Clear();
                    repUnits.Clear(); repRevenue.Clear();
                    regionUnits.Clear(); regionRevenue.Clear();

                    myApp = new Excel.Application();
                    myBook = myApp.Workbooks.Open(openFileDialog.FileName);
                    mySheet = myBook.Sheets[1];
                    myRange = mySheet.UsedRange;

                    int rowCount = myRange.Rows.Count;

                    for (int r = 2; r <= rowCount; r++)
                    {
                        string rep = (mySheet.Cells[r, 3] as Excel.Range)?.Value?.ToString();
                        string region = (mySheet.Cells[r, 2] as Excel.Range)?.Value?.ToString();
                        string item = (mySheet.Cells[r, 4] as Excel.Range)?.Value?.ToString();
                        string unitsStr = (mySheet.Cells[r, 5] as Excel.Range)?.Value?.ToString();
                        string revenueStr = (mySheet.Cells[r, 7] as Excel.Range)?.Value?.ToString(); // Column 7 is Total

                        if (int.TryParse(unitsStr, out int units) && double.TryParse(revenueStr, out double revenue))
                        {
                            if (!string.IsNullOrEmpty(item))
                            {
                                if (!itemUnits.ContainsKey(item)) itemUnits[item] = 0;
                                itemUnits[item] += units;

                                if (!itemRevenue.ContainsKey(item)) itemRevenue[item] = 0;
                                itemRevenue[item] += revenue;
                            }

                            if (!string.IsNullOrEmpty(rep))
                            {
                                if (!repUnits.ContainsKey(rep)) repUnits[rep] = 0;
                                repUnits[rep] += units;

                                if (!repRevenue.ContainsKey(rep)) repRevenue[rep] = 0;
                                repRevenue[rep] += revenue;
                            }

                            if (!string.IsNullOrEmpty(region))
                            {
                                if (!regionUnits.ContainsKey(region)) regionUnits[region] = 0;
                                regionUnits[region] += units;

                                if (!regionRevenue.ContainsKey(region)) regionRevenue[region] = 0;
                                regionRevenue[region] += revenue;
                            }
                        }
                    }

                    fileLoaded = true;
                    lblOutput.Content = "Select data file to continue";
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Error reading Excel file:\n" + ex.Message);
                }
                finally
                {
                    myBook?.Close(false);
                    myApp?.Quit();
                }
            }
        }

        private void Menu_Exit_Click(object sender, RoutedEventArgs e)
        {
            MessageBoxResult result = MessageBox.Show("Really exit?", "Exit Confirmation", MessageBoxButton.YesNo, MessageBoxImage.Question);
            if (result == MessageBoxResult.Yes)
                Application.Current.Shutdown();
        }

        private void RunReport_Click(object sender, RoutedEventArgs e)
        {
            if (!fileLoaded)
            {
                lblOutput.Content = "No data to process";
                return;
            }

            Dictionary<string, int> currentUnits = null;
            Dictionary<string, double> currentRevenue = null;
            string category = "";
            string metric = "";
            string valueType = "";

            if (radItem.IsChecked == true) { currentUnits = itemUnits; currentRevenue = itemRevenue; category = "Item"; }
            else if (radSalesRep.IsChecked == true) { currentUnits = repUnits; currentRevenue = repRevenue; category = "Sales Rep"; }
            else if (radRegion.IsChecked == true) { currentUnits = regionUnits; currentRevenue = regionRevenue; category = "Region"; }

            if (radUnits.IsChecked == true) metric = "Units";
            else if (radRevenue.IsChecked == true) metric = "Revenue";

            if (radHighest.IsChecked == true) valueType = "Highest";
            else if (radLowest.IsChecked == true) valueType = "Lowest";
            else if (radAll.IsChecked == true) valueType = "All";

            if (valueType == "Highest" || valueType == "Lowest")
            {
                if (metric == "Units")
                {
                    var result = GetExtremum(currentUnits, valueType == "Highest");

                    if (category == "Item" && valueType == "Highest")
                        lblOutput.Content = $"Most popular item overall = {result.Key} ({result.Value} units)";
                    else if (category == "Item" && valueType == "Lowest")
                        lblOutput.Content = $"Least popular item overall = {result.Key} ({result.Value} units)";
                    else
                        lblOutput.Content = $"{category} selling the {valueType} {metric} = {result.Key} ({result.Value} units)";
                }
                else if (metric == "Revenue")
                {
                    var result = GetExtremum(currentRevenue, valueType == "Highest");

                    if (category == "Region" && valueType == "Highest")
                        lblOutput.Content = $"Region with Most Revenue was = {result.Key} (${result.Value:F2})";
                    else if (category == "Region" && valueType == "Lowest")
                        lblOutput.Content = $"Region with Least Revenue was = {result.Key} (${result.Value:F2})";
                    else
                        lblOutput.Content = $"{category} with {valueType} {metric} = {result.Key} (${result.Value:F2})";
                }
            }
            else if (valueType == "All")
            {
                StringBuilder sb = new StringBuilder();
                if (metric == "Units")
                {
                    sb.AppendLine($"{metric} Sold by each {category}:");
                    sb.AppendLine(new string('-', 35));
                    foreach (var pair in currentUnits)
                        sb.AppendLine($"{pair.Key} - {pair.Value} units");
                }
                else if (metric == "Revenue")
                {
                    sb.AppendLine($"{metric} from each {category}:");
                    sb.AppendLine(new string('-', 35));
                    foreach (var pair in currentRevenue)
                        sb.AppendLine($"{pair.Key} - ${pair.Value:F2}");
                }
                lblOutput.Content = sb.ToString();
            }
            else
            {
                lblOutput.Content = "No matching report selection was found. Please check your selections.";
            }
        }


        private KeyValuePair<string, int> GetExtremum(Dictionary<string, int> data, bool isMax)
        {
            string key = "";
            int value = isMax ? int.MinValue : int.MaxValue;

            foreach (var pair in data)
            {
                if ((isMax && pair.Value > value) || (!isMax && pair.Value < value))
                {
                    key = pair.Key;
                    value = pair.Value;
                }
            }

            return new KeyValuePair<string, int>(key, value);
        }

        private KeyValuePair<string, double> GetExtremum(Dictionary<string, double> data, bool isMax)
        {
            string key = "";
            double value = isMax ? double.MinValue : double.MaxValue;

            foreach (var pair in data)
            {
                if ((isMax && pair.Value > value) || (!isMax && pair.Value < value))
                {
                    key = pair.Key;
                    value = pair.Value;
                }
            }

            return new KeyValuePair<string, double>(key, value);
        }
    }
}