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
int orderId;

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
    double highBbValue = iBands(NULL, PERIOD_CURRENT, bbPeriod, bbDeviation, 0, PRICE_CLOSE, MODE_UPPER, 0);
    double lowBbValue = iBands(NULL, PERIOD_CURRENT, bbPeriod, bbDeviation, 0, PRICE_CLOSE, MODE_LOWER, 0);

    double highBbValue4 = iBands(NULL, PERIOD_CURRENT, bbPeriod, otherDeviation, 0, PRICE_CLOSE, MODE_UPPER, 0);
    double lowBbValue4 = iBands(NULL, PERIOD_CURRENT, bbPeriod, otherDeviation, 0, PRICE_CLOSE, MODE_LOWER, 0);
    double midBbValue4 = iBands(NULL, PERIOD_CURRENT, bbPeriod, otherDeviation, 0, PRICE_CLOSE, MODE_MAIN, 0);
    
    if(!checkOpenOrderByMagicNumber(magicNumber)) {
      double stopLossPrice;
      double takeProfitPrice;
      double lotSize;
      double entryPrice;

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

      if(orderId < 0) {
        Alert("Order rejected, order error: " + GetLastError());
      }
    } else {
      Alert("Order already open");

      if(OrderSelect(orderId, SELECT_BY_TICKET) == true) {
        int orderType = OrderType();

        double currentExitPoint;

        if(orderType == OP_BUY) {
          currentExitPoint = NormalizeDouble(lowBbValue4, Digits);
        } else {
          currentExitPoint = NormalizeDouble(highBbValue4, Digits);
        }

        double currentMidLine = NormalizeDouble(midBbValue4, Digits);

        double tp = OrderTakeProfit();
        double sl = OrderStopLoss();

        if (tp != currentMidLine || sl != currentExitPoint) {
          bool answer = OrderModify(orderId, OrderOpenPrice(), currentExitPoint, currentMidLine, 0);

          if(answer) {
            Alert("Order modified: " + orderId);
          }
        }
      }
    }
  }
}
//+------------------------------------------------------------------+
