//+------------------------------------------------------------------+
//|                                                   HelloWorld.mq4 |
//|                                                     Mitia Elodie |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Mitia Elodie"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#property show_inputs
#include <TradeCalculation.mqh>
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
input double entryPrice = 1.0005;
input double stopLossPrice = 1.0006;
input double riskRatio = 2;
void OnStart()
  {
    Alert("");
    Alert(calculatePipsDifference(entryPrice, stopLossPrice));

    Alert(calculateStopLossPriceFromRatio(entryPrice, stopLossPrice, riskRatio));
  }
//+------------------------------------------------------------------+

