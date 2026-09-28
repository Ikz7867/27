<?php
declare(strict_types=1);

namespace PriceComp\Contracts;

interface LiveSearchConnector
{
    public function sourceKey(): string;

    /**
     * Search live inventory; caller resolves profile defaults, checks requested locale/currency
     * against verified allowed values and enforces provider access/display/cache policy.
     * Connector validates every returned Money currency equals request currency; otherwise fail.
     * @return iterable<array{externalId:string,title:string,url:string,price:Money,observedAt:\DateTimeImmutable,expiresAt:?\DateTimeImmutable,attribution:array<string,string>}>
     */
    public function search(RegionProfile $region, SourceCredential $credential, LiveSearchRequest $request): iterable;
}
