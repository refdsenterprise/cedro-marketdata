import Foundation

public struct QuoteModel: CedroModel {
    public var values: QuoteValuesModel
    public let type: ContentType
    public let parameter: String
}

public enum QuoteMarketCode: Int, CedroModel {
    case bovespa = 1
    case dowJones = 2
    case bmf = 3
    case indices = 4
    case money = 5
    case soma = 6
    case forex = 7
    case indicators = 8
    case others = 9
    case nyse = 10
    case bats = 11
    case nasdaq = 12
    case bvl = 14
    case spIndexes = 15
    case liffe = 16
    case euronextIndices = 17
    case cme = 18
    case cmeMini = 19
}

public enum QuoteAssetTypeCode: Int, CedroModel {
    case activeInSight = 1
    case option = 2
    case index = 3
    case commodity = 4
    case currency = 5
    case term = 6
    case future = 7
    case auction = 8
    case bonus = 9
    case fractional = 10
    case optionExercise = 11
    case indicator = 12
    case etf = 13
    case volume = 15
    case cashOption = 16
    case optionOnFuture = 17
    case testAsset = 18
}

public enum QuoteMeaningOfMissedOffersAtOpeningPrice: String, CedroModel {
    case buy = "A"
    case sell = "V"
    case uninformed = "0"
}

public enum QuoteOptionType: String, CedroModel {
    case american = "A"
    case european = "E"
    case doesNotExist = "0"
}

public enum QuoteMarketType: String, CedroModel {
    case realTime = "RT"
    case delay = "D"
    case endOfDay = "EOD"
}

public enum QuoteAssetStatus: Int, CedroModel {
    case normal = 0
    case frozen = 1
    case suspended = 2
    case auction = 3
    case inhibited = 4
}

public enum QuoteAssetGroupPhase: String, CedroModel {
    case preOpening = "FOR"
    case openingNormalSession = "A"
    case preClosing = "PN"
    case closing = "N"
    case afterOpeningPre = "E"
    case afterOpening = "R"
    case afterClosing = "NE"
    case end = "F"
}

public struct QuoteValuesModel: CedroModel {
    public var lastModificationTime: String?
    public var lastModificationDate: String?
    public var lastBusinessPrice: Double?
    public var bestBuyOffer: Double?
    public var bestSellingOffer: Double?
    public var timeOfLastDeal: String?
    public var quantityOfCurrentBusiness: Int?
    public var quantityOfLastTrade: Int?
    public var amountOfTradesDone: Int?
    public var cumulativeVolumeOfTrades: Int?
    public var financialVolumeOfTrades: Double?
    public var highestPriceOfTheDay: Double?
    public var lowestPriceOfTheDay: Double?
    public var previousDaysClosingPrice: Double?
    public var openingPrice: Double?
    public var bestBuyOfferTime: String?
    public var bestSellingOfferTime: String?
    public var accumulatedVolumeOfTheBestBuys: Double?
    public var accumulatedVolumeOfBestSellingOffers: Double?
    public var volumeOfTheBestBuyOffer: Int?
    public var volumeOfBestSellingOffer: Int?
    public var variation: Double?
    public var lastWeeksClosingPrice: Double?
    public var lastMonthsClosingPrice: Double?
    public var lastYearsClosingPrice: Double?
    public var previousDaysOpeningPrice: Double?
    public var highestPriceOfTheDayBefore: Double?
    public var lowestPriceOfPreviousDay: Double?
    public var average: Double?
    public var vhDaily: Double?
    public var marketCode: QuoteMarketCode?
    public var assetTypeCode: QuoteAssetTypeCode?
    public var defaultBatch: Int?
    public var assetDescription: String?
    public var sortName: String?
    public var quotationForm: Int?
    public var intradayDate: String?
    public var lasttradeDate: String?
    public var shortAssetDescription: String?
    public var identifierOfTheCanceledDeal: String?
    public var dateOfLastTrade: String?
    public var meaningOfMissedOffersAtOpeningPrice: QuoteMeaningOfMissedOffersAtOpeningPrice?
    public var quantityNotMetAtOpeningPrice: Int?
    public var scheduledTimeToOpenThePaper: String?
    public var rescheduledTimeForPaperOpening: String?
    public var codeOfTheBrokerThatMadeTheBestBuyOffer: Int?
    public var codeOfTheBrokerThatMadeTheBestSellOffer: Int?
    public var codeOfTheBrokerWhoMadeTheLastPurchase: Int?
    public var codeOfTheBrokerThatMadeTheLastSale: Int?
    public var expirationDate: String?
    public var expired: Int?
    public var totalNumberOfRoles: String?
    public var instrumentStatus: Int?
    public var optionType: QuoteOptionType?
    public var theoreticalOpeningPrice: Double?
    public var theoreticalQuantity: Int?
    public var diffCurrentPricePrevious: Double?
    public var dateFromPrevious: String?
    public var marginRangeBTCMarket: Double?
    public var averageVolumeOverLast20Days: Double?
    public var calculatedVariationFieldAccordingly: Double?
    public var marketCapitalization: Double?
    public var marketType: QuoteMarketType?
    public var closingValueInOneWeek: Double?
    public var dayClosingValue: Double?
    public var closingAmountInOneMonth: Double?
    public var fieldCalculatedFromVariationAccordingTo1MonthClosingValue: Double?
    public var closingValueInOneYear: Double?
    public var fieldCalculatedFromVariationAccordingTo1YearClosingValue: Double?
    public var ticksize: Int?
    public var variationOfHourlyVolumeBasedOnAverageHourlyVolumeOverLast20Days: Double?
    public var volumeToTimeVariationBasedOnAverageVolumeToTimeOverLast20Days: Double?
    
    // MARK: - BOVESPA
    
    public var assetStatus: QuoteAssetStatus?
    public var strikePrice: Double?
    public var assetGroupPhase: QuoteAssetGroupPhase?
    public var averageOfThePreviousDay: Double?
    
    // MARK: - BMF
    
    public var numberOfOpenContracts: Int?
    public var numberOfBusinessDaysUntilExpiration: Int?
    public var numberOfDaysToExpire: Int?
    public var settingOfTheDay: Double?
    public var adjustmentFromThePreviousDay: Double?
    public var securityidBMFFix: String?
    public var tickdirectionBMFFIX: String?
    public var tunnelUpperLimit: Double?
    public var tunnelLowerLimit: Double?
    public var tradingPhase: String?
    public var minimumInstrumentTradingVolume: Int?
    public var minimumRangeForPriceIncrements: Double?
    public var minimumQuantityForInstrumentInAnOrder: Int?
    public var maximumQuantityForInstrumentInAnOrder: Int?
    public var uniqueInstrumentIdentificationNumber: Int?
    public var currencyUsedInPrice: String?
    public var securityType: String?
    public var instrumentTradingCode: String?
    public var productAssociatedWithInstrument: Int?
    public var expirationMonthAndYear: String?
    public var optionStrikePrice: Double?
    public var optionStrikePriceCurrency: String?
    public var contractMultiplier: Double?
    public var codeRepresentingTheInstrumentsPriceType: Int?
    public var timeAnInstrumentIsNoLongerTradeable: String?
    public var indicatesTheGroupToWhichTheAssetBelongs: String?
    public var currentAdjustmentInRate: Double?
    public var previousAdjustmentInRate: Double?
    public var currentAdjustmentDateInRate: String?
    public var numberOfWithdrawalsUntilDueDate: Int?
    
    public enum CodingKeys: String, CodingKey, CedroModel, CaseIterable {
        case lastModificationTime = "0"
        case lastModificationDate = "1"
        case lastBusinessPrice = "2"
        case bestBuyOffer = "3"
        case bestSellingOffer = "4"
        case timeOfLastDeal = "5"
        case quantityOfCurrentBusiness = "6"
        case quantityOfLastTrade = "7"
        case amountOfTradesDone = "8"
        case cumulativeVolumeOfTrades = "9"
        case financialVolumeOfTrades = "10"
        case highestPriceOfTheDay = "11"
        case lowestPriceOfTheDay = "12"
        case previousDaysClosingPrice = "13"
        case openingPrice = "14"
        case bestBuyOfferTime = "15"
        case bestSellingOfferTime = "16"
        case accumulatedVolumeOfTheBestBuys = "17"
        case accumulatedVolumeOfBestSellingOffers = "18"
        case volumeOfTheBestBuyOffer = "19"
        case volumeOfBestSellingOffer = "20"
        case variation = "21"
        case lastWeeksClosingPrice = "36"
        case lastMonthsClosingPrice = "37"
        case lastYearsClosingPrice = "38"
        case previousDaysOpeningPrice = "39"
        case highestPriceOfTheDayBefore = "40"
        case lowestPriceOfPreviousDay = "41"
        case average = "42"
        case vhDaily = "43"
        case marketCode = "44"
        case assetTypeCode = "45"
        case defaultBatch = "46"
        case assetDescription = "47"
        case sortName = "48"
        case quotationForm = "49"
        case intradayDate = "50"
        case lasttradeDate = "51"
        case shortAssetDescription = "52"
        case identifierOfTheCanceledDeal = "53"
        case dateOfLastTrade = "54"
        case meaningOfMissedOffersAtOpeningPrice = "56"
        case quantityNotMetAtOpeningPrice = "57"
        case scheduledTimeToOpenThePaper = "58"
        case rescheduledTimeForPaperOpening = "59"
        case codeOfTheBrokerThatMadeTheBestBuyOffer = "60"
        case codeOfTheBrokerThatMadeTheBestSellOffer = "61"
        case codeOfTheBrokerWhoMadeTheLastPurchase = "62"
        case codeOfTheBrokerThatMadeTheLastSale = "63"
        case expirationDate = "64"
        case expired = "65"
        case totalNumberOfRoles = "66"
        case instrumentStatus = "67"
        case optionType = "72"
        case theoreticalOpeningPrice = "82"
        case theoreticalQuantity = "83"
        case diffCurrentPricePrevious = "86"
        case dateFromPrevious = "87"
        case marginRangeBTCMarket = "90"
        case averageVolumeOverLast20Days = "94"
        case calculatedVariationFieldAccordingly = "10094"
        case marketCapitalization = "95"
        case marketType = "96"
        case closingValueInOneWeek = "97"
        case dayClosingValue = "10097"
        case closingAmountInOneMonth = "98"
        case fieldCalculatedFromVariationAccordingTo1MonthClosingValue = "10098"
        case closingValueInOneYear = "99"
        case fieldCalculatedFromVariationAccordingTo1YearClosingValue = "10099"
        case ticksize = "110"
        case variationOfHourlyVolumeBasedOnAverageHourlyVolumeOverLast20Days = "134"
        case volumeToTimeVariationBasedOnAverageVolumeToTimeOverLast20Days = "135"
        case assetStatus = "84"
        case strikePrice = "85"
        case assetGroupPhase = "88"
        case averageOfThePreviousDay = "89"
        case numberOfOpenContracts = "100"
        case numberOfBusinessDaysUntilExpiration = "101"
        case numberOfDaysToExpire = "102"
        case settingOfTheDay = "103"
        case adjustmentFromThePreviousDay = "104"
        case securityidBMFFix = "105"
        case tickdirectionBMFFIX = "106"
        case tunnelUpperLimit = "107"
        case tunnelLowerLimit = "108"
        case tradingPhase = "109"
        case minimumInstrumentTradingVolume = "111"
        case minimumRangeForPriceIncrements = "112"
        case minimumQuantityForInstrumentInAnOrder = "113"
        case maximumQuantityForInstrumentInAnOrder = "114"
        case uniqueInstrumentIdentificationNumber = "115"
        case currencyUsedInPrice = "116"
        case securityType = "117"
        case instrumentTradingCode = "118"
        case productAssociatedWithInstrument = "119"
        case expirationMonthAndYear = "120"
        case optionStrikePrice = "121"
        case optionStrikePriceCurrency = "122"
        case contractMultiplier = "123"
        case codeRepresentingTheInstrumentsPriceType = "124"
        case timeAnInstrumentIsNoLongerTradeable = "125"
        case indicatesTheGroupToWhichTheAssetBelongs = "126"
        case currentAdjustmentInRate = "127"
        case previousAdjustmentInRate = "128"
        case currentAdjustmentDateInRate = "129"
        case numberOfWithdrawalsUntilDueDate = "130"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        lastModificationTime = try values.decodeIfPresent(String.self, forKey: .lastModificationTime)
        lastModificationDate = try values.decodeIfPresent(String.self, forKey: .lastModificationDate)
        lastBusinessPrice = try values.decodeIfPresent(String.self, forKey: .lastBusinessPrice)?.asDouble
        bestBuyOffer = try values.decodeIfPresent(String.self, forKey: .bestBuyOffer)?.asDouble
        bestSellingOffer = try values.decodeIfPresent(String.self, forKey: .bestSellingOffer)?.asDouble
        timeOfLastDeal = try values.decodeIfPresent(String.self, forKey: .timeOfLastDeal)
        quantityOfCurrentBusiness = try values.decodeIfPresent(String.self, forKey: .quantityOfCurrentBusiness)?.asInt
        quantityOfLastTrade = try values.decodeIfPresent(String.self, forKey: .quantityOfLastTrade)?.asInt
        amountOfTradesDone = try values.decodeIfPresent(String.self, forKey: .amountOfTradesDone)?.asInt
        cumulativeVolumeOfTrades = try values.decodeIfPresent(String.self, forKey: .cumulativeVolumeOfTrades)?.asInt
        financialVolumeOfTrades = try values.decodeIfPresent(String.self, forKey: .financialVolumeOfTrades)?.asDouble
        highestPriceOfTheDay = try values.decodeIfPresent(String.self, forKey: .highestPriceOfTheDay)?.asDouble
        lowestPriceOfTheDay = try values.decodeIfPresent(String.self, forKey: .lowestPriceOfTheDay)?.asDouble
        previousDaysClosingPrice = try values.decodeIfPresent(String.self, forKey: .previousDaysClosingPrice)?.asDouble
        openingPrice = try values.decodeIfPresent(String.self, forKey: .openingPrice)?.asDouble
        bestBuyOfferTime = try values.decodeIfPresent(String.self, forKey: .bestBuyOfferTime)
        bestSellingOfferTime = try values.decodeIfPresent(String.self, forKey: .bestSellingOfferTime)
        accumulatedVolumeOfTheBestBuys = try values.decodeIfPresent(String.self, forKey: .accumulatedVolumeOfTheBestBuys)?.asDouble
        accumulatedVolumeOfBestSellingOffers = try values.decodeIfPresent(String.self, forKey: .accumulatedVolumeOfBestSellingOffers)?.asDouble
        volumeOfTheBestBuyOffer = try values.decodeIfPresent(String.self, forKey: .volumeOfTheBestBuyOffer)?.asInt
        volumeOfBestSellingOffer = try values.decodeIfPresent(String.self, forKey: .volumeOfBestSellingOffer)?.asInt
        variation = try values.decodeIfPresent(String.self, forKey: .variation)?.asDouble
        lastWeeksClosingPrice = try values.decodeIfPresent(String.self, forKey: .lastWeeksClosingPrice)?.asDouble
        lastMonthsClosingPrice = try values.decodeIfPresent(String.self, forKey: .lastMonthsClosingPrice)?.asDouble
        lastYearsClosingPrice = try values.decodeIfPresent(String.self, forKey: .lastYearsClosingPrice)?.asDouble
        previousDaysOpeningPrice = try values.decodeIfPresent(String.self, forKey: .previousDaysOpeningPrice)?.asDouble
        highestPriceOfTheDayBefore = try values.decodeIfPresent(String.self, forKey: .highestPriceOfTheDayBefore)?.asDouble
        lowestPriceOfPreviousDay = try values.decodeIfPresent(String.self, forKey: .lowestPriceOfPreviousDay)?.asDouble
        average = try values.decodeIfPresent(String.self, forKey: .average)?.asDouble
        vhDaily = try values.decodeIfPresent(String.self, forKey: .vhDaily)?.asDouble
        
        marketCode = nil
        if let auxmarketCode = try values.decodeIfPresent(String.self, forKey: .marketCode)?.asInt {
            marketCode = QuoteMarketCode(rawValue: auxmarketCode)
        }
        
        assetTypeCode = nil
        if let auxassetTypeCode = try values.decodeIfPresent(String.self, forKey: .assetTypeCode)?.asInt {
            assetTypeCode = QuoteAssetTypeCode(rawValue: auxassetTypeCode)
        }
        
        defaultBatch = try values.decodeIfPresent(String.self, forKey: .defaultBatch)?.asInt
        assetDescription = try values.decodeIfPresent(String.self, forKey: .assetDescription)
        sortName = try values.decodeIfPresent(String.self, forKey: .sortName)
        quotationForm = try values.decodeIfPresent(String.self, forKey: .quotationForm)?.asInt
        intradayDate = try values.decodeIfPresent(String.self, forKey: .intradayDate)
        lasttradeDate = try values.decodeIfPresent(String.self, forKey: .lasttradeDate)
        shortAssetDescription = try values.decodeIfPresent(String.self, forKey: .shortAssetDescription)
        identifierOfTheCanceledDeal = try values.decodeIfPresent(String.self, forKey: .identifierOfTheCanceledDeal)
        dateOfLastTrade = try values.decodeIfPresent(String.self, forKey: .dateOfLastTrade)
        meaningOfMissedOffersAtOpeningPrice = nil
        if let auxmeaningOfMissedOffersAtOpeningPrice = try values.decodeIfPresent(String.self, forKey: .meaningOfMissedOffersAtOpeningPrice) {
            meaningOfMissedOffersAtOpeningPrice = QuoteMeaningOfMissedOffersAtOpeningPrice(rawValue: auxmeaningOfMissedOffersAtOpeningPrice)
        }
        
        quantityNotMetAtOpeningPrice = try values.decodeIfPresent(String.self, forKey: .quantityNotMetAtOpeningPrice)?.asInt
        scheduledTimeToOpenThePaper = try values.decodeIfPresent(String.self, forKey: .scheduledTimeToOpenThePaper)
        rescheduledTimeForPaperOpening = try values.decodeIfPresent(String.self, forKey: .rescheduledTimeForPaperOpening)
        codeOfTheBrokerThatMadeTheBestBuyOffer = try values.decodeIfPresent(String.self, forKey: .codeOfTheBrokerThatMadeTheBestBuyOffer)?.asInt
        codeOfTheBrokerThatMadeTheBestSellOffer = try values.decodeIfPresent(String.self, forKey: .codeOfTheBrokerThatMadeTheBestSellOffer)?.asInt
        codeOfTheBrokerWhoMadeTheLastPurchase = try values.decodeIfPresent(String.self, forKey: .codeOfTheBrokerWhoMadeTheLastPurchase)?.asInt
        codeOfTheBrokerThatMadeTheLastSale = try values.decodeIfPresent(String.self, forKey: .codeOfTheBrokerThatMadeTheLastSale)?.asInt
        expirationDate = try values.decodeIfPresent(String.self, forKey: .expirationDate)
        expired = try values.decodeIfPresent(String.self, forKey: .expired)?.asInt
        totalNumberOfRoles = try values.decodeIfPresent(String.self, forKey: .totalNumberOfRoles)
        instrumentStatus = try values.decodeIfPresent(String.self, forKey: .instrumentStatus)?.asInt
        optionType = nil
        if let auxoptionType = try values.decodeIfPresent(String.self, forKey: .optionType) {
            optionType = QuoteOptionType(rawValue: auxoptionType)
        }
        
        theoreticalOpeningPrice = try values.decodeIfPresent(String.self, forKey: .theoreticalOpeningPrice)?.asDouble
        theoreticalQuantity = try values.decodeIfPresent(String.self, forKey: .theoreticalQuantity)?.asInt
        diffCurrentPricePrevious = try values.decodeIfPresent(String.self, forKey: .diffCurrentPricePrevious)?.asDouble
        dateFromPrevious = try values.decodeIfPresent(String.self, forKey: .dateFromPrevious)
        marginRangeBTCMarket = try values.decodeIfPresent(String.self, forKey: .marginRangeBTCMarket)?.asDouble
        averageVolumeOverLast20Days = try values.decodeIfPresent(String.self, forKey: .averageVolumeOverLast20Days)?.asDouble
        calculatedVariationFieldAccordingly = try values.decodeIfPresent(String.self, forKey: .calculatedVariationFieldAccordingly)?.asDouble
        marketCapitalization = try values.decodeIfPresent(String.self, forKey: .marketCapitalization)?.asDouble
        marketType = nil
        if let auxmarketType = try values.decodeIfPresent(String.self, forKey: .marketType) {
            marketType = QuoteMarketType(rawValue: auxmarketType)
        }
        
        closingValueInOneWeek = try values.decodeIfPresent(String.self, forKey: .closingValueInOneWeek)?.asDouble
        dayClosingValue = try values.decodeIfPresent(String.self, forKey: .dayClosingValue)?.asDouble
        closingAmountInOneMonth = try values.decodeIfPresent(String.self, forKey: .closingAmountInOneMonth)?.asDouble
        fieldCalculatedFromVariationAccordingTo1MonthClosingValue = try values.decodeIfPresent(String.self, forKey: .fieldCalculatedFromVariationAccordingTo1MonthClosingValue)?.asDouble
        closingValueInOneYear = try values.decodeIfPresent(String.self, forKey: .closingValueInOneYear)?.asDouble
        fieldCalculatedFromVariationAccordingTo1YearClosingValue = try values.decodeIfPresent(String.self, forKey: .fieldCalculatedFromVariationAccordingTo1YearClosingValue)?.asDouble
        ticksize = try values.decodeIfPresent(String.self, forKey: .ticksize)?.asInt
        variationOfHourlyVolumeBasedOnAverageHourlyVolumeOverLast20Days = try values.decodeIfPresent(String.self, forKey: .variationOfHourlyVolumeBasedOnAverageHourlyVolumeOverLast20Days)?.asDouble
        volumeToTimeVariationBasedOnAverageVolumeToTimeOverLast20Days = try values.decodeIfPresent(String.self, forKey: .volumeToTimeVariationBasedOnAverageVolumeToTimeOverLast20Days)?.asDouble
        
        // MARK: - BOVESPA
        assetStatus = nil
        if let auxassetStatus = try values.decodeIfPresent(String.self, forKey: .assetStatus)?.asInt {
            assetStatus = QuoteAssetStatus(rawValue: auxassetStatus)
        }
        
        strikePrice = try values.decodeIfPresent(String.self, forKey: .strikePrice)?.asDouble
        assetGroupPhase = nil
        if let auxassetGroupPhase = try values.decodeIfPresent(String.self, forKey: .assetGroupPhase) {
            assetGroupPhase = QuoteAssetGroupPhase(rawValue: auxassetGroupPhase)
        }
        
        averageOfThePreviousDay = try values.decodeIfPresent(String.self, forKey: .averageOfThePreviousDay)?.asDouble
        
        // MARK: - BMF
        
        numberOfOpenContracts = try values.decodeIfPresent(String.self, forKey: .numberOfOpenContracts)?.asInt
        numberOfBusinessDaysUntilExpiration = try values.decodeIfPresent(String.self, forKey: .numberOfBusinessDaysUntilExpiration)?.asInt
        numberOfDaysToExpire = try values.decodeIfPresent(String.self, forKey: .numberOfDaysToExpire)?.asInt
        settingOfTheDay = try values.decodeIfPresent(String.self, forKey: .settingOfTheDay)?.asDouble
        adjustmentFromThePreviousDay = try values.decodeIfPresent(String.self, forKey: .adjustmentFromThePreviousDay)?.asDouble
        securityidBMFFix = try values.decodeIfPresent(String.self, forKey: .securityidBMFFix)
        tickdirectionBMFFIX = try values.decodeIfPresent(String.self, forKey: .tickdirectionBMFFIX)
        tunnelUpperLimit = try values.decodeIfPresent(String.self, forKey: .tunnelUpperLimit)?.asDouble
        tunnelLowerLimit = try values.decodeIfPresent(String.self, forKey: .tunnelLowerLimit)?.asDouble
        tradingPhase = try values.decodeIfPresent(String.self, forKey: .tradingPhase)
        minimumInstrumentTradingVolume = try values.decodeIfPresent(String.self, forKey: .minimumInstrumentTradingVolume)?.asInt
        minimumRangeForPriceIncrements = try values.decodeIfPresent(String.self, forKey: .minimumRangeForPriceIncrements)?.asDouble
        minimumQuantityForInstrumentInAnOrder = try values.decodeIfPresent(String.self, forKey: .minimumQuantityForInstrumentInAnOrder)?.asInt
        maximumQuantityForInstrumentInAnOrder = try values.decodeIfPresent(String.self, forKey: .maximumQuantityForInstrumentInAnOrder)?.asInt
        uniqueInstrumentIdentificationNumber = try values.decodeIfPresent(String.self, forKey: .uniqueInstrumentIdentificationNumber)?.asInt
        currencyUsedInPrice = try values.decodeIfPresent(String.self, forKey: .currencyUsedInPrice)
        securityType = try values.decodeIfPresent(String.self, forKey: .securityType)
        instrumentTradingCode = try values.decodeIfPresent(String.self, forKey: .instrumentTradingCode)
        productAssociatedWithInstrument = try values.decodeIfPresent(String.self, forKey: .productAssociatedWithInstrument)?.asInt
        expirationMonthAndYear = try values.decodeIfPresent(String.self, forKey: .expirationMonthAndYear)
        optionStrikePrice = try values.decodeIfPresent(String.self, forKey: .optionStrikePrice)?.asDouble
        optionStrikePriceCurrency = try values.decodeIfPresent(String.self, forKey: .optionStrikePriceCurrency)
        contractMultiplier = try values.decodeIfPresent(String.self, forKey: .contractMultiplier)?.asDouble
        codeRepresentingTheInstrumentsPriceType = try values.decodeIfPresent(String.self, forKey: .codeRepresentingTheInstrumentsPriceType)?.asInt
        timeAnInstrumentIsNoLongerTradeable = try values.decodeIfPresent(String.self, forKey: .timeAnInstrumentIsNoLongerTradeable)
        indicatesTheGroupToWhichTheAssetBelongs = try values.decodeIfPresent(String.self, forKey: .indicatesTheGroupToWhichTheAssetBelongs)
        currentAdjustmentInRate = try values.decodeIfPresent(String.self, forKey: .currentAdjustmentInRate)?.asDouble
        previousAdjustmentInRate = try values.decodeIfPresent(String.self, forKey: .previousAdjustmentInRate)?.asDouble
        currentAdjustmentDateInRate = try values.decodeIfPresent(String.self, forKey: .currentAdjustmentDateInRate)
        numberOfWithdrawalsUntilDueDate = try values.decodeIfPresent(String.self, forKey: .numberOfWithdrawalsUntilDueDate)?.asInt
    }
    
    public mutating func update(quote: Self) -> [QuoteValuesModel.CodingKeys] {
        var updatedFields = [QuoteValuesModel.CodingKeys]()
        if let lastModificationTime = quote.lastModificationTime { self.lastModificationTime = lastModificationTime; updatedFields.append(.lastModificationTime) }
        if let lastModificationDate = quote.lastModificationDate { self.lastModificationDate = lastModificationDate; updatedFields.append(.lastModificationDate) }
        if let lastBusinessPrice = quote.lastBusinessPrice { self.lastBusinessPrice = lastBusinessPrice; updatedFields.append(.lastBusinessPrice) }
        if let bestBuyOffer = quote.bestBuyOffer { self.bestBuyOffer = bestBuyOffer; updatedFields.append(.bestBuyOffer) }
        if let bestSellingOffer = quote.bestSellingOffer { self.bestSellingOffer = bestSellingOffer; updatedFields.append(.bestSellingOffer) }
        if let timeOfLastDeal = quote.timeOfLastDeal { self.timeOfLastDeal = timeOfLastDeal; updatedFields.append(.timeOfLastDeal) }
        if let quantityOfCurrentBusiness = quote.quantityOfCurrentBusiness { self.quantityOfCurrentBusiness = quantityOfCurrentBusiness; updatedFields.append(.quantityOfCurrentBusiness) }
        if let quantityOfLastTrade = quote.quantityOfLastTrade { self.quantityOfLastTrade = quantityOfLastTrade; updatedFields.append(.quantityOfLastTrade) }
        if let amountOfTradesDone = quote.amountOfTradesDone { self.amountOfTradesDone = amountOfTradesDone; updatedFields.append(.amountOfTradesDone) }
        if let cumulativeVolumeOfTrades = quote.cumulativeVolumeOfTrades { self.cumulativeVolumeOfTrades = cumulativeVolumeOfTrades; updatedFields.append(.cumulativeVolumeOfTrades) }
        if let financialVolumeOfTrades = quote.financialVolumeOfTrades { self.financialVolumeOfTrades = financialVolumeOfTrades; updatedFields.append(.financialVolumeOfTrades) }
        if let highestPriceOfTheDay = quote.highestPriceOfTheDay { self.highestPriceOfTheDay = highestPriceOfTheDay; updatedFields.append(.highestPriceOfTheDay) }
        if let lowestPriceOfTheDay = quote.lowestPriceOfTheDay { self.lowestPriceOfTheDay = lowestPriceOfTheDay; updatedFields.append(.lowestPriceOfTheDay) }
        if let previousDaysClosingPrice = quote.previousDaysClosingPrice { self.previousDaysClosingPrice = previousDaysClosingPrice; updatedFields.append(.previousDaysClosingPrice) }
        if let openingPrice = quote.openingPrice { self.openingPrice = openingPrice; updatedFields.append(.openingPrice) }
        if let bestBuyOfferTime = quote.bestBuyOfferTime { self.bestBuyOfferTime = bestBuyOfferTime; updatedFields.append(.bestBuyOfferTime) }
        if let bestSellingOfferTime = quote.bestSellingOfferTime { self.bestSellingOfferTime = bestSellingOfferTime; updatedFields.append(.bestSellingOfferTime) }
        if let accumulatedVolumeOfTheBestBuys = quote.accumulatedVolumeOfTheBestBuys { self.accumulatedVolumeOfTheBestBuys = accumulatedVolumeOfTheBestBuys; updatedFields.append(.accumulatedVolumeOfTheBestBuys) }
        if let accumulatedVolumeOfBestSellingOffers = quote.accumulatedVolumeOfBestSellingOffers { self.accumulatedVolumeOfBestSellingOffers = accumulatedVolumeOfBestSellingOffers; updatedFields.append(.accumulatedVolumeOfBestSellingOffers) }
        if let volumeOfTheBestBuyOffer = quote.volumeOfTheBestBuyOffer { self.volumeOfTheBestBuyOffer = volumeOfTheBestBuyOffer; updatedFields.append(.volumeOfTheBestBuyOffer) }
        if let volumeOfBestSellingOffer = quote.volumeOfBestSellingOffer { self.volumeOfBestSellingOffer = volumeOfBestSellingOffer; updatedFields.append(.volumeOfBestSellingOffer) }
        if let variation = quote.variation { self.variation = variation; updatedFields.append(.variation) }
        if let lastWeeksClosingPrice = quote.lastWeeksClosingPrice { self.lastWeeksClosingPrice = lastWeeksClosingPrice; updatedFields.append(.lastWeeksClosingPrice) }
        if let lastMonthsClosingPrice = quote.lastMonthsClosingPrice { self.lastMonthsClosingPrice = lastMonthsClosingPrice; updatedFields.append(.lastMonthsClosingPrice) }
        if let lastYearsClosingPrice = quote.lastYearsClosingPrice { self.lastYearsClosingPrice = lastYearsClosingPrice; updatedFields.append(.lastYearsClosingPrice) }
        if let previousDaysOpeningPrice = quote.previousDaysOpeningPrice { self.previousDaysOpeningPrice = previousDaysOpeningPrice; updatedFields.append(.previousDaysOpeningPrice) }
        if let highestPriceOfTheDayBefore = quote.highestPriceOfTheDayBefore { self.highestPriceOfTheDayBefore = highestPriceOfTheDayBefore; updatedFields.append(.highestPriceOfTheDayBefore) }
        if let lowestPriceOfPreviousDay = quote.lowestPriceOfPreviousDay { self.lowestPriceOfPreviousDay = lowestPriceOfPreviousDay; updatedFields.append(.lowestPriceOfPreviousDay) }
        if let average = quote.average { self.average = average; updatedFields.append(.average) }
        if let vhDaily = quote.vhDaily { self.vhDaily = vhDaily; updatedFields.append(.vhDaily) }
        if let marketCode = quote.marketCode { self.marketCode = marketCode; updatedFields.append(.marketCode) }
        if let assetTypeCode = quote.assetTypeCode { self.assetTypeCode = assetTypeCode; updatedFields.append(.assetTypeCode) }
        if let defaultBatch = quote.defaultBatch { self.defaultBatch = defaultBatch; updatedFields.append(.defaultBatch) }
        if let assetDescription = quote.assetDescription { self.assetDescription = assetDescription; updatedFields.append(.assetDescription) }
        if let sortName = quote.sortName { self.sortName = sortName; updatedFields.append(.sortName) }
        if let quotationForm = quote.quotationForm { self.quotationForm = quotationForm; updatedFields.append(.quotationForm) }
        if let intradayDate = quote.intradayDate { self.intradayDate = intradayDate; updatedFields.append(.intradayDate) }
        if let lasttradeDate = quote.lasttradeDate { self.lasttradeDate = lasttradeDate; updatedFields.append(.lasttradeDate) }
        if let shortAssetDescription = quote.shortAssetDescription { self.shortAssetDescription = shortAssetDescription; updatedFields.append(.shortAssetDescription) }
        if let identifierOfTheCanceledDeal = quote.identifierOfTheCanceledDeal { self.identifierOfTheCanceledDeal = identifierOfTheCanceledDeal; updatedFields.append(.identifierOfTheCanceledDeal) }
        if let dateOfLastTrade = quote.dateOfLastTrade { self.dateOfLastTrade = dateOfLastTrade; updatedFields.append(.dateOfLastTrade) }
        if let meaningOfMissedOffersAtOpeningPrice = quote.meaningOfMissedOffersAtOpeningPrice { self.meaningOfMissedOffersAtOpeningPrice = meaningOfMissedOffersAtOpeningPrice; updatedFields.append(.meaningOfMissedOffersAtOpeningPrice) }
        if let quantityNotMetAtOpeningPrice = quote.quantityNotMetAtOpeningPrice { self.quantityNotMetAtOpeningPrice = quantityNotMetAtOpeningPrice; updatedFields.append(.quantityNotMetAtOpeningPrice) }
        if let scheduledTimeToOpenThePaper = quote.scheduledTimeToOpenThePaper { self.scheduledTimeToOpenThePaper = scheduledTimeToOpenThePaper; updatedFields.append(.scheduledTimeToOpenThePaper) }
        if let rescheduledTimeForPaperOpening = quote.rescheduledTimeForPaperOpening { self.rescheduledTimeForPaperOpening = rescheduledTimeForPaperOpening; updatedFields.append(.rescheduledTimeForPaperOpening) }
        if let codeOfTheBrokerThatMadeTheBestBuyOffer = quote.codeOfTheBrokerThatMadeTheBestBuyOffer { self.codeOfTheBrokerThatMadeTheBestBuyOffer = codeOfTheBrokerThatMadeTheBestBuyOffer; updatedFields.append(.codeOfTheBrokerThatMadeTheBestBuyOffer) }
        if let codeOfTheBrokerThatMadeTheBestSellOffer = quote.codeOfTheBrokerThatMadeTheBestSellOffer { self.codeOfTheBrokerThatMadeTheBestSellOffer = codeOfTheBrokerThatMadeTheBestSellOffer; updatedFields.append(.codeOfTheBrokerThatMadeTheBestSellOffer) }
        if let codeOfTheBrokerWhoMadeTheLastPurchase = quote.codeOfTheBrokerWhoMadeTheLastPurchase { self.codeOfTheBrokerWhoMadeTheLastPurchase = codeOfTheBrokerWhoMadeTheLastPurchase; updatedFields.append(.codeOfTheBrokerWhoMadeTheLastPurchase) }
        if let codeOfTheBrokerThatMadeTheLastSale = quote.codeOfTheBrokerThatMadeTheLastSale { self.codeOfTheBrokerThatMadeTheLastSale = codeOfTheBrokerThatMadeTheLastSale; updatedFields.append(.codeOfTheBrokerThatMadeTheLastSale) }
        if let expirationDate = quote.expirationDate { self.expirationDate = expirationDate; updatedFields.append(.expirationDate) }
        if let expired = quote.expired { self.expired = expired; updatedFields.append(.expired) }
        if let totalNumberOfRoles = quote.totalNumberOfRoles { self.totalNumberOfRoles = totalNumberOfRoles; updatedFields.append(.totalNumberOfRoles) }
        if let instrumentStatus = quote.instrumentStatus { self.instrumentStatus = instrumentStatus; updatedFields.append(.instrumentStatus) }
        if let optionType = quote.optionType { self.optionType = optionType; updatedFields.append(.optionType) }
        if let theoreticalOpeningPrice = quote.theoreticalOpeningPrice { self.theoreticalOpeningPrice = theoreticalOpeningPrice; updatedFields.append(.theoreticalOpeningPrice) }
        if let theoreticalQuantity = quote.theoreticalQuantity { self.theoreticalQuantity = theoreticalQuantity; updatedFields.append(.theoreticalQuantity) }
        if let diffCurrentPricePrevious = quote.diffCurrentPricePrevious { self.diffCurrentPricePrevious = diffCurrentPricePrevious; updatedFields.append(.diffCurrentPricePrevious) }
        if let dateFromPrevious = quote.dateFromPrevious { self.dateFromPrevious = dateFromPrevious; updatedFields.append(.dateFromPrevious) }
        if let marginRangeBTCMarket = quote.marginRangeBTCMarket { self.marginRangeBTCMarket = marginRangeBTCMarket; updatedFields.append(.marginRangeBTCMarket) }
        if let averageVolumeOverLast20Days = quote.averageVolumeOverLast20Days { self.averageVolumeOverLast20Days = averageVolumeOverLast20Days; updatedFields.append(.averageVolumeOverLast20Days) }
        if let calculatedVariationFieldAccordingly = quote.calculatedVariationFieldAccordingly { self.calculatedVariationFieldAccordingly = calculatedVariationFieldAccordingly; updatedFields.append(.calculatedVariationFieldAccordingly) }
        if let marketCapitalization = quote.marketCapitalization { self.marketCapitalization = marketCapitalization; updatedFields.append(.marketCapitalization) }
        if let marketType = quote.marketType { self.marketType = marketType; updatedFields.append(.marketType) }
        if let closingValueInOneWeek = quote.closingValueInOneWeek { self.closingValueInOneWeek = closingValueInOneWeek; updatedFields.append(.closingValueInOneWeek) }
        if let dayClosingValue = quote.dayClosingValue { self.dayClosingValue = dayClosingValue; updatedFields.append(.dayClosingValue) }
        if let closingAmountInOneMonth = quote.closingAmountInOneMonth { self.closingAmountInOneMonth = closingAmountInOneMonth; updatedFields.append(.closingAmountInOneMonth) }
        if let fieldCalculatedFromVariationAccordingTo1MonthClosingValue = quote.fieldCalculatedFromVariationAccordingTo1MonthClosingValue { self.fieldCalculatedFromVariationAccordingTo1MonthClosingValue = fieldCalculatedFromVariationAccordingTo1MonthClosingValue; updatedFields.append(.fieldCalculatedFromVariationAccordingTo1MonthClosingValue) }
        if let closingValueInOneYear = quote.closingValueInOneYear { self.closingValueInOneYear = closingValueInOneYear; updatedFields.append(.closingValueInOneYear) }
        if let fieldCalculatedFromVariationAccordingTo1YearClosingValue = quote.fieldCalculatedFromVariationAccordingTo1YearClosingValue { self.fieldCalculatedFromVariationAccordingTo1YearClosingValue = fieldCalculatedFromVariationAccordingTo1YearClosingValue; updatedFields.append(.fieldCalculatedFromVariationAccordingTo1YearClosingValue) }
        if let ticksize = quote.ticksize { self.ticksize = ticksize; updatedFields.append(.ticksize) }
        if let variationOfHourlyVolumeBasedOnAverageHourlyVolumeOverLast20Days = quote.variationOfHourlyVolumeBasedOnAverageHourlyVolumeOverLast20Days { self.variationOfHourlyVolumeBasedOnAverageHourlyVolumeOverLast20Days = variationOfHourlyVolumeBasedOnAverageHourlyVolumeOverLast20Days; updatedFields.append(.variationOfHourlyVolumeBasedOnAverageHourlyVolumeOverLast20Days) }
        if let volumeToTimeVariationBasedOnAverageVolumeToTimeOverLast20Days = quote.volumeToTimeVariationBasedOnAverageVolumeToTimeOverLast20Days { self.volumeToTimeVariationBasedOnAverageVolumeToTimeOverLast20Days = volumeToTimeVariationBasedOnAverageVolumeToTimeOverLast20Days; updatedFields.append(.volumeToTimeVariationBasedOnAverageVolumeToTimeOverLast20Days) }
        if let assetStatus = quote.assetStatus { self.assetStatus = assetStatus; updatedFields.append(.assetStatus) }
        if let strikePrice = quote.strikePrice { self.strikePrice = strikePrice; updatedFields.append(.strikePrice) }
        if let assetGroupPhase = quote.assetGroupPhase { self.assetGroupPhase = assetGroupPhase; updatedFields.append(.assetGroupPhase) }
        if let averageOfThePreviousDay = quote.averageOfThePreviousDay { self.averageOfThePreviousDay = averageOfThePreviousDay; updatedFields.append(.averageOfThePreviousDay) }
        if let numberOfOpenContracts = quote.numberOfOpenContracts { self.numberOfOpenContracts = numberOfOpenContracts; updatedFields.append(.numberOfOpenContracts) }
        if let numberOfBusinessDaysUntilExpiration = quote.numberOfBusinessDaysUntilExpiration { self.numberOfBusinessDaysUntilExpiration = numberOfBusinessDaysUntilExpiration; updatedFields.append(.numberOfBusinessDaysUntilExpiration) }
        if let numberOfDaysToExpire = quote.numberOfDaysToExpire { self.numberOfDaysToExpire = numberOfDaysToExpire; updatedFields.append(.numberOfDaysToExpire) }
        if let settingOfTheDay = quote.settingOfTheDay { self.settingOfTheDay = settingOfTheDay; updatedFields.append(.settingOfTheDay) }
        if let adjustmentFromThePreviousDay = quote.adjustmentFromThePreviousDay { self.adjustmentFromThePreviousDay = adjustmentFromThePreviousDay; updatedFields.append(.adjustmentFromThePreviousDay) }
        if let securityidBMFFix = quote.securityidBMFFix { self.securityidBMFFix = securityidBMFFix; updatedFields.append(.securityidBMFFix) }
        if let tickdirectionBMFFIX = quote.tickdirectionBMFFIX { self.tickdirectionBMFFIX = tickdirectionBMFFIX; updatedFields.append(.tickdirectionBMFFIX) }
        if let tunnelUpperLimit = quote.tunnelUpperLimit { self.tunnelUpperLimit = tunnelUpperLimit; updatedFields.append(.tunnelUpperLimit) }
        if let tunnelLowerLimit = quote.tunnelLowerLimit { self.tunnelLowerLimit = tunnelLowerLimit; updatedFields.append(.tunnelLowerLimit) }
        if let tradingPhase = quote.tradingPhase { self.tradingPhase = tradingPhase; updatedFields.append(.tradingPhase) }
        if let minimumInstrumentTradingVolume = quote.minimumInstrumentTradingVolume { self.minimumInstrumentTradingVolume = minimumInstrumentTradingVolume; updatedFields.append(.minimumInstrumentTradingVolume) }
        if let minimumRangeForPriceIncrements = quote.minimumRangeForPriceIncrements { self.minimumRangeForPriceIncrements = minimumRangeForPriceIncrements; updatedFields.append(.minimumRangeForPriceIncrements) }
        if let minimumQuantityForInstrumentInAnOrder = quote.minimumQuantityForInstrumentInAnOrder { self.minimumQuantityForInstrumentInAnOrder = minimumQuantityForInstrumentInAnOrder; updatedFields.append(.minimumQuantityForInstrumentInAnOrder) }
        if let maximumQuantityForInstrumentInAnOrder = quote.maximumQuantityForInstrumentInAnOrder { self.maximumQuantityForInstrumentInAnOrder = maximumQuantityForInstrumentInAnOrder; updatedFields.append(.maximumQuantityForInstrumentInAnOrder) }
        if let uniqueInstrumentIdentificationNumber = quote.uniqueInstrumentIdentificationNumber { self.uniqueInstrumentIdentificationNumber = uniqueInstrumentIdentificationNumber; updatedFields.append(.uniqueInstrumentIdentificationNumber) }
        if let currencyUsedInPrice = quote.currencyUsedInPrice { self.currencyUsedInPrice = currencyUsedInPrice; updatedFields.append(.currencyUsedInPrice) }
        if let securityType = quote.securityType { self.securityType = securityType; updatedFields.append(.securityType) }
        if let instrumentTradingCode = quote.instrumentTradingCode { self.instrumentTradingCode = instrumentTradingCode; updatedFields.append(.instrumentTradingCode) }
        if let productAssociatedWithInstrument = quote.productAssociatedWithInstrument { self.productAssociatedWithInstrument = productAssociatedWithInstrument; updatedFields.append(.productAssociatedWithInstrument) }
        if let expirationMonthAndYear = quote.expirationMonthAndYear { self.expirationMonthAndYear = expirationMonthAndYear; updatedFields.append(.expirationMonthAndYear) }
        if let optionStrikePrice = quote.optionStrikePrice { self.optionStrikePrice = optionStrikePrice; updatedFields.append(.optionStrikePrice) }
        if let optionStrikePriceCurrency = quote.optionStrikePriceCurrency { self.optionStrikePriceCurrency = optionStrikePriceCurrency; updatedFields.append(.optionStrikePriceCurrency) }
        if let contractMultiplier = quote.contractMultiplier { self.contractMultiplier = contractMultiplier; updatedFields.append(.contractMultiplier) }
        if let codeRepresentingTheInstrumentsPriceType = quote.codeRepresentingTheInstrumentsPriceType { self.codeRepresentingTheInstrumentsPriceType = codeRepresentingTheInstrumentsPriceType; updatedFields.append(.codeRepresentingTheInstrumentsPriceType) }
        if let timeAnInstrumentIsNoLongerTradeable = quote.timeAnInstrumentIsNoLongerTradeable { self.timeAnInstrumentIsNoLongerTradeable = timeAnInstrumentIsNoLongerTradeable; updatedFields.append(.timeAnInstrumentIsNoLongerTradeable) }
        if let indicatesTheGroupToWhichTheAssetBelongs = quote.indicatesTheGroupToWhichTheAssetBelongs { self.indicatesTheGroupToWhichTheAssetBelongs = indicatesTheGroupToWhichTheAssetBelongs; updatedFields.append(.indicatesTheGroupToWhichTheAssetBelongs) }
        if let currentAdjustmentInRate = quote.currentAdjustmentInRate { self.currentAdjustmentInRate = currentAdjustmentInRate; updatedFields.append(.currentAdjustmentInRate) }
        if let previousAdjustmentInRate = quote.previousAdjustmentInRate { self.previousAdjustmentInRate = previousAdjustmentInRate; updatedFields.append(.previousAdjustmentInRate) }
        if let currentAdjustmentDateInRate = quote.currentAdjustmentDateInRate { self.currentAdjustmentDateInRate = currentAdjustmentDateInRate; updatedFields.append(.currentAdjustmentDateInRate) }
        if let numberOfWithdrawalsUntilDueDate = quote.numberOfWithdrawalsUntilDueDate { self.numberOfWithdrawalsUntilDueDate = numberOfWithdrawalsUntilDueDate; updatedFields.append(.numberOfWithdrawalsUntilDueDate) }
        return updatedFields
    }
}
