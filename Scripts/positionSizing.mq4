//+------------------------------------------------------------------+
//|                                               positionSizing.mq4 |
//|                                                     Mitia Elodie |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Mitia Elodie"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#include <TradeCalculation.mqh>

double maxLossPercentage = 0.02;
double maxLossInPips = 40;
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
    Alert("");
    Alert("Optimal lot size: " + optimalLotSize(maxLossPercentage, 1.0000, 1.0030));
  }
//+------------------------------------------------------------------+