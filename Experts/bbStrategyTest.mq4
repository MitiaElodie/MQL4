//+------------------------------------------------------------------+
//|                                               bbStrategyTest.mq4 |
//|                                                     Mitia Elodie |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Mitia Elodie"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#include <TradeCalculation.mqh>
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+

int bbPeriod = 20;
int bbDeviation = 1;

int otherDeviation = 4;
double maxLossPercentage = 0.01;
int magicNumber = 111;

int OnInit()
  {
    Alert("");
   Alert("The EA just started");
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   Alert("The EA just closed");
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick() {
  if(IsTradingAllowed()) {
    if(!checkOpenOrderByMagicNumber(magicNumber)) {

      double highBbValue = iBands(NULL, PERIOD_CURRENT, bbPeriod, bbDeviation, 0, PRICE_CLOSE, MODE_UPPER, 0);
      double lowBbValue = iBands(NULL, PERIOD_CURRENT, bbPeriod, bbDeviation, 0, PRICE_CLOSE, MODE_LOWER, 0);

      double stopLossPrice;
      double takeProfitPrice;
      double lotSize;
      double entryPrice;

      double highBbValue4 = iBands(NULL, PERIOD_CURRENT, bbPeriod, otherDeviation, 0, PRICE_CLOSE, MODE_UPPER, 0);
      double lowBbValue4 = iBands(NULL, PERIOD_CURRENT, bbPeriod, otherDeviation, 0, PRICE_CLOSE, MODE_LOWER, 0);
      double midBbValue4 = iBands(NULL, PERIOD_CURRENT, bbPeriod, otherDeviation, 0, PRICE_CLOSE, MODE_MAIN, 0);

      int orderId;
      if(Ask < lowBbValue) {
        Alert("BUY");
        entryPrice = Ask;
        stopLossPrice = lowBbValue4;
        takeProfitPrice = midBbValue4;
        lotSize = optimalLotSize(maxLossPercentage, entryPrice, stopLossPrice);
        
        // orderId = OrderSend(NULL, OP_BUYLIMIT, lotSize, entryPrice, 10, stopLossPrice, takeProfitPrice, 0, magicNumber);
        orderId = OrderSend(NULL, OP_BUYLIMIT, 0.01, entryPrice, 10, stopLossPrice, takeProfitPrice, 0, magicNumber);

      } else if(Bid > highBbValue) {
        Alert("SELL");
        entryPrice = Bid;
        stopLossPrice = highBbValue4;
        takeProfitPrice = midBbValue4;
        lotSize = optimalLotSize(maxLossPercentage, entryPrice, stopLossPrice);
      
        // orderId = OrderSend(NULL, OP_SELLLIMIT, lotSize, entryPrice, 10, stopLossPrice, takeProfitPrice, 0, magicNumber);
        orderId = OrderSend(NULL, OP_SELLLIMIT, 0.01, entryPrice, 10, stopLossPrice, takeProfitPrice, 0, magicNumber);
      } else {
        Alert("No signal was found, will recompute again on next price update");
      }
      
      Alert("Entry Price = " + entryPrice);
      Alert("Stop Loss Price = " + stopLossPrice);
      Alert("Take Profit Price = " + takeProfitPrice);
      Alert("Lot size = " + lotSize);

      if(orderId < 0) {
        Alert("Order rejected, order error: " + GetLastError());
      }
    }
  }
}
//+------------------------------------------------------------------+
