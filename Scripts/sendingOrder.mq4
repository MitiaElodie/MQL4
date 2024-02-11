//+------------------------------------------------------------------+
//|                                                 sendingOrder.mq4 |
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
    if(IsTradingAllowed()) {
      double stopLossPrice = CalculateStopLossPrice(true, Bid, 10);
      double takeProfitPrice = CalculateTakeProfitPrice(true, Bid, 20);

      // slippage value is in point if the broker has 5 digits and in pip if the broker has 4digits
      // if 10pips/10pips, don't put the slippage to 1 pips as it is 10% of your goal
      int orderId = OrderSend(NULL, OP_BUY, 0.01, Bid, 10, stopLossPrice, takeProfitPrice);
      Alert("OrderId: " + orderId);
    }
  }
//+------------------------------------------------------------------+
