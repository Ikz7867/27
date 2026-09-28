<?php
declare(strict_types=1);

namespace PriceComp\Contracts;

interface Notifier
{
    /** Recipient consent/unsubscribe must be checked before dispatch; idempotencyKey prevents repeats. */
    public function send(string $recipientId, string $templateKey, array $templateData, string $idempotencyKey): void;
}
