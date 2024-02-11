//+------------------------------------------------------------------+
//|                                                     bbScript.mq4 |
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
int bbPeriod = 20;
int bbDeviation = 1;

int otherDeviation = 4;

void OnStart()
  {
//---
  Alert("");
  
  if(IsTradingAllowed()) {
    double highBbValue = iBands(NULL, PERIOD_CURRENT, bbPeriod, bbDeviation, 0, PRICE_CLOSE, MODE_UPPER, 0);
    double lowBbValue = iBands(NULL, PERIOD_CURRENT, bbPeriod, bbDeviation, 0, PRICE_CLOSE, MODE_LOWER, 0);

    double stopLossPrice;
    double takeProfitPrice;

    double highBbValue4 = iBands(NULL, PERIOD_CURRENT, bbPeriod, otherDeviation, 0, PRICE_CLOSE, MODE_UPPER, 0);
    double lowBbValue4 = iBands(NULL, PERIOD_CURRENT, bbPeriod, otherDeviation, 0, PRICE_CLOSE, MODE_LOWER, 0);
    double midBbValue4 = iBands(NULL, PERIOD_CURRENT, bbPeriod, otherDeviation, 0, PRICE_CLOSE, MODE_MAIN, 0);

    int orderId;

    if(Ask < lowBbValue) {
      Alert("BUY");
      stopLossPrice = lowBbValue4;
      takeProfitPrice = midBbValue4;
      Alert("Entry Price = " + Ask);
      Alert("Stop Loss Price = " + stopLossPrice);
      Alert("Take Profit Price = " + takeProfitPrice); 
      
      orderId = OrderSend(NULL, OP_BUYLIMIT, 0.01, Ask, 10, stopLossPrice, takeProfitPrice);

    } else if(Bid > highBbValue) {
      Alert("SELL");
      stopLossPrice = highBbValue4;
      takeProfitPrice = midBbValue4;
      Alert("Entry Price = " + Bid);
      Alert("Stop Loss Price = " + stopLossPrice);
      Alert("Take Profit Price = " + takeProfitPrice);
    
      orderId = OrderSend(NULL, OP_SELLLIMIT, 0.01, Bid, 10, stopLossPrice, takeProfitPrice);
    }

    if(orderId < 0) {
      Alert("Order rejected, order error: " + GetLastError());
    }
  }
  
  }
//+------------------------------------------------------------------+
