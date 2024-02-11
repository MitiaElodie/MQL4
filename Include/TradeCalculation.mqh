//+------------------------------------------------------------------+
//|                                             TradeCalculation.mqh |
//|                                                     Mitia Elodie |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Mitia Elodie"
#property link      "https://www.mql5.com"
#property strict

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

double optimalLotSize(double maxLossPercentage, int maxLossInPips) {
  double accountEquity = AccountEquity();

  double lotSize = MarketInfo(NULL, MODE_LOTSIZE);

  // the exchange rate of the quote currency to the deposit currency
  double tickValue = MarketInfo(NULL, MODE_TICKVALUE);
  if(Digits <= 3) {
    tickValue = tickValue / 100;
  }

  double maxLossAccountCurrency = accountEquity * maxLossPercentage;

  double maxLossQuoteCurrency = maxLossAccountCurrency / tickValue;

  double optimalLotSize = maxLossQuoteCurrency / (maxLossInPips * getPipValue()) / lotSize;
  optimalLotSize = NormalizeDouble(optimalLotSize, 2);

  return optimalLotSize;
}

double optimalLotSize(double maxLossPercentage, double entryPrice, double stopLossPrice) {
  double maxLossInPips = MathAbs(entryPrice - stopLossPrice) / getPipValue();
  Alert("Max loss in pips: " + maxLossInPips);

  double result = optimalLotSize(maxLossPercentage, maxLossInPips);

  return result;
}