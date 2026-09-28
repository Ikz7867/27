<?php
declare(strict_types=1);

namespace PriceComp\Contracts;

/** Validated, enabled source program; endpoint host must pass the connector allowlist. */
final readonly class RegionProfile
{
    /**
     * @param list<string> $allowedCurrencyCodes Verified request/response currencies; default only if provider support is unknown.
     * @param list<string> $allowedLocales Verified request locales; default only if provider support is unknown.
     * @param array<string, scalar|null> $parameters
     */
    public function __construct(
        public int $networkRegionId,
        public string $sourceKey,
        public string $countryCode,
        public string $programKey,
        public string $defaultCurrencyCode,
        public string $defaultLocale,
        public array $allowedCurrencyCodes,
        public array $allowedLocales,
        public ?string $endpointUrl,
        public array $parameters,
    ) {}
}
