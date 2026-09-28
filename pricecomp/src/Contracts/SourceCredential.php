<?php
declare(strict_types=1);

namespace PriceComp\Contracts;

/** Decrypted in memory immediately before a connector call; never log or persist this value. */
final readonly class SourceCredential
{
    public function __construct(
        public int $sourceAccountId,
        public string $secret,
    ) {}
}
