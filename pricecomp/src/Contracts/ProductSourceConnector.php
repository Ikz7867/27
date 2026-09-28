<?php
declare(strict_types=1);

namespace PriceComp\Contracts;

interface ProductSourceConnector
{
    /** Stable network.source_key; a single implementation serves multiple RegionProfile values. */
    public function sourceKey(): string;

    /**
     * Search or page a catalog API. The caller validates region/account access and rate limits.
     * The importer upserts canonical (region, externalId) and separate (offer, account) price/link.
     * @param array<string, scalar|null> $query Includes cursor/limit where supported.
     * @return iterable<array{externalId:string,title:string,url:string,price:Money,observedAt:\DateTimeImmutable}>
     */
    public function fetchProducts(RegionProfile $region, SourceCredential $credential, array $query): iterable;
}
