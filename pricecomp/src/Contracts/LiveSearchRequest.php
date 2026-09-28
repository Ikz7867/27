<?php
declare(strict_types=1);

namespace PriceComp\Contracts;

/** No traveller names/contact data. Locale/currency are the actual requested values, validated against the region profile. */
final readonly class LiveSearchRequest
{
    /**
     * @param array<string, string> $locations Provider-neutral origin/destination or stay location IDs.
     * @param array<string, string> $dates ISO date strings keyed by journey/stay leg.
     * @param array{adults:int,children:int,childAges:list<int>,rooms?:int} $travellers
     */
    public function __construct(
        public string $vertical,
        public array $locations,
        public array $dates,
        public array $travellers,
        public string $locale,
        public string $currencyCode,
    ) {}
}
