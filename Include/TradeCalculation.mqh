//+------------------------------------------------------------------+
//|                                             TradeCalculation.mqh |
//|                                                     Mitia Elodie |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Mitia Elodie"
#property link      "https://www.mql5.com"
#property strict

enum TrendDirection
{
    TREND_BULLISH,
    TREND_BEARISH,
    TREND_NEUTRAL
};
// Position true = buy
// Position false = sell
double CalculateStopLossPrice(bool position, double entryPrice, int stopLossPips) {
  double result = 0;

  if (position) {
    result = entryPrice - stopLossPips * getPipValue();
  } else {
    result = entryPrice + stopLossPips * getPipValue();
  }

  return result;
}

double CalculateTakeProfitPrice(bool position, double entryPrice, int takeProfitPips) {
  double result = 0;

  if (position) {
    result = entryPrice + takeProfitPips * getPipValue();
  } else {
    result = entryPrice - takeProfitPips * getPipValue();
  }

  return result;
}

double getPipValue() {
   if (_Digits >= 4) {
      return 0.0001;
   } else {
      return 0.01;
   }
}

bool IsTradingAllowed() {
  if(!IsTradeAllowed()) {
    Alert("Expert Advisor is NOT allowed to trade. Check AutoTrading.");
    return false;
  }

  if(!IsTradeAllowed(NULL, TimeCurrent())) {
    Alert("Trading NOT allowed for " + Symbol() + " at this time.");
    return false;
  }

  return true;
}

// the exchange rate of the quote cuccccccccccrrency to the deposit currency
double getTickValue() {
  double tickValue = MarketInfo(NULL, MODE_TICKVALUE);
  if (Digits <= 3) {
    tickValue = tickValue / 100;
  }
  return tickValue;
}

double optimalLotSize(double maxLossPercentage, int maxLossInPips) {
  double accountEquity = AccountEquity();

  double lotSize = MarketInfo(NULL, MODE_LOTSIZE);

  // the exchange rate of the quote currency to the deposit currency
  double tickValue = getTickValue();

  double maxLossAccountCurrency = accountEquity * maxLossPercentage;

  double maxLossQuoteCurrency = maxLossAccountCurrency / tickValue;

  double optimalLotSize = -1;
  
  if (maxLossInPips != 0) {
    optimalLotSize = maxLossQuoteCurrency / (maxLossInPips * getPipValue()) / lotSize;
    optimalLotSize = NormalizeDouble(optimalLotSize, 2);
  } else {
    Alert("The maximum loss in pips should be greater than 0.");
  }

  return optimalLotSize;
}

double optimalLotSize(double maxLossPercentage, double entryPrice, double stopLossPrice) {
  double maxLossInPips = NormalizeDouble(MathAbs(entryPrice - stopLossPrice) / getPipValue(), 1);
  Alert("Max loss in pips: " + maxLossInPips);

  double result = optimalLotSize(maxLossPercentage, maxLossInPips);

  return result;
}

bool checkOpenOrderByMagicNumber(int magicNumber) {
    int openOrders = OrdersTotal();

    for (int i = 0; i < openOrders; i++)
    {
      if(OrderSelect(i, SELECT_BY_POS) == true) {
        if(OrderMagicNumber() == magicNumber) {
          Print("There is an open order with the magic number " + magicNumber);
          return true;
        }
      }
    }
    return false;
}

TrendDirection CheckMarketSentiment() {
  // Calculate the 50-period Simple Moving Average
  double ma50 = iMA(Symbol(), 0, 50, 0, MODE_SMA, PRICE_CLOSE, 0);
  // Calculate the 200-period Simple Moving Average
  double ma200 = iMA(Symbol(), 0, 200, 0, MODE_SMA, PRICE_CLOSE, 0);
  // Compare the two moving averages
  if (ma50 > ma200) {
    return TREND_BULLISH;
  } else if (ma50 < ma200) {
    return TREND_BEARISH;
  } else {
    return TREND_NEUTRAL;
  }
}

double calculatePipsDifference(double price1, double price2) {
  return NormalizeDouble(MathAbs(price1 - price2) / getPipValue(), 1);
}

double calculateStopLossPriceFromRatio(double entryPrice, double takeProfitPrice, double ratio) {
  double result;

  double takeProfitPips = calculatePipsDifference(entryPrice, takeProfitPrice);
  double stopLossPips = NormalizeDouble((takeProfitPips / ratio), 2);
  double stopLossPipsValue = stopLossPips * getPipValue();

  if(takeProfitPrice > entryPrice) {
    result = entryPrice - stopLossPipsValue;
  } else {
    result = entryPrice + stopLossPipsValue;
  }

  return NormalizeDouble(result, Digits);
}