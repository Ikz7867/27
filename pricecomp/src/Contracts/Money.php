<?php
declare(strict_types=1);

namespace PriceComp\Contracts;

/** Currency uses ISO 4217; minor-unit exponent comes from currency configuration. */
final readonly class Money
{
    public function __construct(
        public int $minorUnits,
        public string $currencyCode,
    ) {}
}
