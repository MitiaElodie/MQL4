//+------------------------------------------------------------------+
//|                                             DisplayFunctions.mqh |
//|                                                     Mitia Elodie |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Mitia Elodie"
#property link      "https://www.mql5.com"
#property strict

void DrawVerticalLine(int index, color lineColor = clrRed)
{
    // Calculate the time of the candle
    datetime candleTime = iTime(Symbol(), 0, index);
    string lineName = "VerticalLine" + index + lineColor;

    // Draw the line
    ObjectCreate(0, lineName, OBJ_VLINE, 0, 0, 0);
    ObjectSetInteger(0, lineName, OBJPROP_COLOR, lineColor);        // Line color
    ObjectSetInteger(0, lineName, OBJPROP_WIDTH, 1);              // Line width
    ObjectSetInteger(0, lineName, OBJPROP_TIME1, candleTime);     // Start time
    ObjectSetInteger(0, lineName, OBJPROP_RAY_RIGHT, false);      // Draw the line to the left
}

void DrawHorizontalLine(double price, color lineColor = clrRed)
{
    string lineName = "HorizontalLine_" + DoubleToString(price, 4); // Unique name for the line

    // Draw the line
    ObjectCreate(0, lineName, OBJ_HLINE, 0, 0, price);
    ObjectSetInteger(0, lineName, OBJPROP_COLOR, lineColor);   // Line color
    ObjectSetInteger(0, lineName, OBJPROP_WIDTH, 1);        // Line width
}