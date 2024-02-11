//+------------------------------------------------------------------+
//|                                                movingAverage.mq4 |
//|                                                     Mitia Elodie |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Mitia Elodie"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

int maPeriod = 20;
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
//---
    double maValue = NormalizeDouble(iMA(NULL, PERIOD_CURRENT, maPeriod, 1, MODE_SMA, PRICE_CLOSE, 0), Digits);
    Alert(maValue);
  }
//+------------------------------------------------------------------+
