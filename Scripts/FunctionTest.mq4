//+------------------------------------------------------------------+
//|                                                 FunctionTest.mq4 |
//|                                                     Mitia Elodie |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Mitia Elodie"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#property show_inputs
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
#include <TradeCalculation.mqh>

extern int takeProfitPips = 50;
extern int stopLossPips = 50;
void OnStart()
  {
//---
    double signalPrice = 1.28956;
    
    if(Ask < signalPrice){
      Alert("Price is below signalPrice, sending buy order");
      double stopLossPrice = CalculateStopLossPrice(true, Ask, stopLossPips);
      double takeProfitPrice = CalculateTakeProfitPrice(true, Ask, takeProfitPips);
      Alert("Entry price: " + Ask);
      Alert("Step loss price: " + stopLossPrice);
      Alert("Take profit price: " + takeProfitPrice);
    } else if(Bid > signalPrice) {
      Alert("Price is above signal price, sending short order");
      double stopLossPrice = CalculateStopLossPrice(false, Bid, stopLossPips);
      double takeProfitPrice = CalculateTakeProfitPrice(false, Bid, takeProfitPips);
      Alert("Entry price: " + Bid);
      Alert("Step loss price: " + stopLossPrice);
      Alert("Take profit price: " + takeProfitPrice);
    }
  }
//+------------------------------------------------------------------+