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
#include <DisplayFunctions.mqh>
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+

void OnStart()
  {
    Alert("");
    
    int bar = findFirstPeakIndex();
    Alert(bar);
    DrawVerticalLine(bar);

    bar = findFirstLowIndex();
    Alert(bar);
    DrawVerticalLine(bar, clrGreen);
  }
//+------------------------------------------------------------------+
