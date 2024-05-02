using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using System.Globalization;
using System.Windows.Forms;

namespace SimpleDrawing
{
    public static class Simulation
    {
         public static List<Dictionary<String, List<double>>> SolveEquation(string equation, double step, double time, double startPoint)
        {
            List<String> equationLines = new List<string>();
            equationLines = BrakeStringInLines(equation);
            Dictionary<String, Double> variables = CreateVariablesList(equationLines);
            Dictionary<String, String> derivatives = CreateDerivativesList(equationLines);

            Dictionary<String, List<Double>> variables_history;
            variables_history = new Dictionary<String, List<Double>>();
            foreach (String derivativeName in variables.Keys)
            {
                variables_history.Add(derivativeName, new List<Double>());
                variables_history[derivativeName].Add(variables[derivativeName]);
            }

            List<double> xValues = new List<double>();
            for (double t = startPoint; t <= time; t += step)
            {
                xValues.Add(t);
                foreach (KeyValuePair<String, String> derivative in derivatives)
                {
                    String expression = derivative.Value;
                    foreach (KeyValuePair<String, Double> variable in variables)
                        expression = expression.Replace(variable.Key, variable.Value.ToString());

                    double at = SolveExpression(expression);
                    Double nextValue = variables[derivative.Key] + step * at;
                    variables_history[derivative.Key].Add(nextValue);
                }

                foreach (KeyValuePair<String, List<Double>> variable in variables_history)
                    variables[variable.Key] = variable.Value[variable.Value.Count - 1];
            }

            List<Dictionary<String, List<double>>> results = new List<Dictionary<String, List<double>>>();

            Dictionary<String, List<double>> dict = new Dictionary<String, List<double>>();
            foreach (KeyValuePair<String, List<double>> pair in variables_history)
            {
                if (pair.Value.Count > 1)
                {
                    dict = new Dictionary<String, List<double>>();
                    dict.Add(pair.Key, pair.Value.GetRange(0, pair.Value.Count - 1));
                    results.Add(dict);
                }
            }

            return results;
        }

        private static Dictionary<String, Double> CreateVariablesList(List<String> equationLines)
        {
            Dictionary<String, Double> variables = new Dictionary<String, Double>();

            foreach (String line in equationLines)
            {
                String currentLine = line.Replace(" ", "");
                if (currentLine.Contains("'="))
                    continue;

                String variableName = currentLine.Substring(0, currentLine.IndexOf("="));
                String variableExpression = currentLine.Substring(currentLine.IndexOf("=") + 1);

                foreach (KeyValuePair<String, Double> variable in variables)
                    variableExpression = variableExpression.Replace(variable.Key, variable.Value.ToString());

                variables.Add(variableName, SolveExpression(variableExpression));
            }

            return variables;
        }

        private static Dictionary<String, String> CreateDerivativesList(List<String> equationLines)
        {
            Dictionary<String, String> derivatives = new Dictionary<String, String>();

            foreach (String line in equationLines)
            {
                String currentLine = line.Replace(" ", "");
                if (!currentLine.Contains("'="))
                    continue;

                String derivativeName = currentLine.Substring(0, currentLine.IndexOf("'="));
                String derivativeExpression = currentLine.Substring(currentLine.IndexOf("'=") + 2);

                derivatives.Add(derivativeName, derivativeExpression);
            }

            return derivatives;
        }

        private static Double SolveExpression(String expression)
        {
            // Малко извращение с десетичната точка при различните локализации
            char uiSep = CultureInfo.CurrentUICulture.NumberFormat.NumberDecimalSeparator[0];
            expression = expression.Replace('.', uiSep);
            expression = expression.Replace(',', uiSep);
            if (expression.StartsWith("("))
            {
                int opening_brackets = 1, closing_brackets = 0, current_symbol = 1;
                while (opening_brackets != closing_brackets)
                {
                    if (expression[current_symbol] == '(')
                        opening_brackets++;
                    else if (expression[current_symbol] == ')')
                        closing_brackets++;

                    current_symbol++;
                }
                String expr = expression.Substring(1, current_symbol - 2);
                expression = expression.Remove(0, current_symbol);

                Match operation = Regex.Match(expression, @"^[\+\-\*\/]");
                if (operation.Success)
                {
                    expression = expression.Remove(0, operation.Value.Length);
                    switch (operation.Value)
                    {
                        case "+":
                            {
                                return SolveExpression(expr) + SolveExpression(expression);
                            }
                        case "-":
                            {
                                return SolveExpression(expr) - SolveExpression(expression);
                            }
                        case "*":
                            {
                                return SolveExpression(expr) * SolveExpression(expression);
                            }
                        case "/":
                            {
                                return SolveExpression(expr) / SolveExpression(expression);
                            }
                    }
                }
                else
                    return SolveExpression(expr);
            }

            Match constant = Regex.Match(expression, @"(^-*\d+)((\.|\,)(\d+))?");
            if (constant.Success)
            {
                expression = expression.Remove(0, constant.Value.Length);

                Match operation = Regex.Match(expression, @"^[\+\-\*\/]");
                if (operation.Success)
                {
                    expression = expression.Remove(0, operation.Value.Length);
                    switch (operation.Value)
                    {
                        case "+":
                            {
                                return Double.Parse(constant.Value) + SolveExpression(expression);
                            }
                        case "-":
                            {
                                return Double.Parse(constant.Value) - SolveExpression(expression);
                            }
                        case "*":
                            {
                                return Double.Parse(constant.Value) * SolveExpression(expression);
                            }
                        case "/":
                            {
                                return Double.Parse(constant.Value) / SolveExpression(expression);
                            }
                    }
                }
                else
                    return Double.Parse(constant.Value);
            }
            else
                //throw new Exception("Invalid Expression");
                MessageBox.Show("You have entered invalid expression! Revise and try again", "Something went wrong", MessageBoxButtons.OK,MessageBoxIcon.Error);

            return 0;
        }

        private static List<String> BrakeStringInLines(String inputString)
        {
            List<String> lines = new List<String>();
            string[] linesArray = inputString.Split(new char[] { '\r', '\n' }, StringSplitOptions.RemoveEmptyEntries);
            lines.AddRange(linesArray);
            return lines;
        }
    }
}
