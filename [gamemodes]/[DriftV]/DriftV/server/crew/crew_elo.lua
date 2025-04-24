local K_FACTOR_LOW = 32
local K_FACTOR_MEDIUM = 24
local K_FACTOR_HIGH = 16
local RATING_THRESHOLD_LOW = 2100
local RATING_THRESHOLD_MEDIUM = 2400
local INITIAL_RATING = 1400

local function ExpectedScores(RatA, RatB)
    local expA = 1 / (1 + 10 ^ ((RatB - RatA) / 400))
    local expB = 1 / (1 + 10 ^ ((RatA - RatB) / 400))
    return expA, expB
end

local function UpdateRating(Rat, Score, ExpScore)
    local K = K_FACTOR_HIGH

    if Rat < RATING_THRESHOLD_LOW then
        K = K_FACTOR_LOW
    elseif Rat < RATING_THRESHOLD_MEDIUM then
        K = K_FACTOR_MEDIUM
    end

    return math.floor(Rat + K * (Score - ExpScore))
end

local function NewRating()
    return INITIAL_RATING
end

function CrewEloNewRating(RatA, RatB, ScoreA, ScoreB)
    local ExpA, ExpB = ExpectedScores(RatA, RatB)
    return UpdateRating(RatA, ScoreA, ExpA), UpdateRating(RatB, ScoreB, ExpB)
end