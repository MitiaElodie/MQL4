//+------------------------------------------------------------------+
//|                                           ToloPositionSizing.mq4 |
//|                                                     Mitia Elodie |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Mitia Elodie"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#include <TradeCalculation.mqh>
#property show_inputs

input double entryPrice = 1.0000;
input double stopLossPrice = 1.0030;
input double maxLossPercentage = 1;
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
    Alert("");
    double finalMaxLossPercentage = maxLossPercentage / 100;
    Alert("Optimal lot size: " + optimalLotSize(finalMaxLossPercentage, entryPrice, stopLossPrice));
  }
//+------------------------------------------------------------------+