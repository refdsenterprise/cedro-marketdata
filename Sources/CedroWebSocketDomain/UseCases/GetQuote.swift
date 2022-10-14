import Foundation

public protocol GetQuote {
    typealias Result = Swift.Result<(QuoteModel), CedroError>
    func get(withBody body: GetQuoteModel, completion: @escaping (Result) -> Void)
}

public struct GetQuoteModel: CedroModel {
    public var token: String
    public var module: Module = .quotes
    public var service: Service = .quote
    public var parameterGet: String
    public var parameters: GetQuoteParameters
    
    public init(token: String, parameterGet: String, parameters: GetQuoteParameters) {
        self.token = token
        self.parameterGet = parameterGet
        self.parameters = parameters
    }
}

public struct GetQuoteParameters: CedroModel {
    public var subsbribetype: SubscribeType
    public var filter: String
    public var delay: String = ""
    
    public init(subsbribetype: SubscribeType, fields: [QuoteValuesModel.CodingKeys] = [
        .lastModificationTime,
        .lastModificationDate,
        .lastBusinessPrice,
        .bestBuyOffer,
        .bestSellingOffer,
        .timeOfLastDeal,
        .quantityOfLastTrade,
        .amountOfTradesDone,
        .cumulativeVolumeOfTrades,
        .financialVolumeOfTrades,
        .highestPriceOfTheDay,
        .lowestPriceOfTheDay,
        .previousDaysClosingPrice,
        .openingPrice,
        .accumulatedVolumeOfTheBestBuys,
        .accumulatedVolumeOfBestSellingOffers,
        .volumeOfTheBestBuyOffer,
        .volumeOfBestSellingOffer,
        .variation,
        .lastWeeksClosingPrice,
        .lastMonthsClosingPrice,
        .lastYearsClosingPrice,
        .previousDaysOpeningPrice,
        .highestPriceOfTheDayBefore,
        .lowestPriceOfPreviousDay,
        .average,
        .vhDaily,
        .marketCode,
        .assetTypeCode,
        .defaultBatch,
        .assetDescription,
        .sortName,
        .quotationForm,
        .dateOfLastTrade,
        .meaningOfMissedOffersAtOpeningPrice,
        .quantityNotMetAtOpeningPrice,
        .scheduledTimeToOpenThePaper,
        .rescheduledTimeForPaperOpening,
        .expirationDate,
        .expired,
        .totalNumberOfRoles,
        .instrumentStatus,
        .optionType,
        .theoreticalOpeningPrice,
        .theoreticalQuantity,
        .diffCurrentPricePrevious,
        .averageVolumeOverLast20Days,
        .calculatedVariationFieldAccordingly,
        .dayClosingValue,
        .closingAmountInOneMonth,
        .fieldCalculatedFromVariationAccordingTo1MonthClosingValue,
        .closingValueInOneYear,
        .fieldCalculatedFromVariationAccordingTo1YearClosingValue,
        .ticksize,
        .variationOfHourlyVolumeBasedOnAverageHourlyVolumeOverLast20Days,
        .volumeToTimeVariationBasedOnAverageVolumeToTimeOverLast20Days,
        .assetStatus,
        .strikePrice,
        .assetGroupPhase,
        .numberOfOpenContracts,
        .numberOfBusinessDaysUntilExpiration,
        .numberOfDaysToExpire,
        .settingOfTheDay,
        .adjustmentFromThePreviousDay,
        .securityidBMFFix,
        .tickdirectionBMFFIX,
        .tunnelUpperLimit,
        .tunnelLowerLimit,
        .minimumInstrumentTradingVolume,
        .minimumRangeForPriceIncrements,
        .currencyUsedInPrice,
        .securityType,
        .optionStrikePrice,
        .contractMultiplier,
        .currentAdjustmentInRate,
        .previousAdjustmentInRate,
        .numberOfWithdrawalsUntilDueDate
    ], delay: Int? = nil) {
        self.subsbribetype = subsbribetype
        self.filter = "\(fields.map({ $0.rawValue }).joined(separator: ","))"
        if let delay = delay { self.delay = "\(delay)" }
    }
}
