<?php
declare(strict_types=1);

namespace PriceComp\Contracts;

interface PaymentGateway
{
    /**
     * Return a hosted HTTPS checkout URL; no card data traverses this application.
     * $intentId is stable across retries and mapped to a unique business key.
     */
    public function createHostedCheckout(Money $amount, string $purpose, string $intentId, string $successUrl, string $cancelUrl): string;

    /**
     * Verify signature over raw bytes before returning data. Throw on invalid/unknown signatures.
     * @param array<string,string> $headers
     * @return array{eventId:string,intentId:string,status:string,amount:Money}
     */
    public function verifyWebhook(string $rawBody, array $headers): array;
}
