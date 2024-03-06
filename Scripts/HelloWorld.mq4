//+------------------------------------------------------------------+
//|                                                   HelloWorld.mq4 |
//|                                                     Mitia Elodie |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Mitia Elodie"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#include <TradeCalculation.mqh>
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+

void OnStart()
  {
    Alert("");
    
    int bar = 0;
    bool isPeakValue = false;

    while(isPeakValue == false) {
      isPeakValue = isPeak(bar);
      if(!isPeakValue) {
        bar++;
      }
    }
    Alert(bar);
    DrawVerticalLine(bar);

    bar = 0;
    bool isLowValue = false;

    while(isLowValue == false) {
      isLowValue = isLow(bar);
      if(!isLowValue) {
        bar++;
      }
    }
    Alert(bar);
    DrawVerticalLine(bar, clrGreen);
  }
//+------------------------------------------------------------------+

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