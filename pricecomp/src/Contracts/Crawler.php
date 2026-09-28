<?php
declare(strict_types=1);

namespace PriceComp\Contracts;

interface Crawler
{
    /**
     * Only approved hosts; enforce robots.txt, DNS/IP and redirect checks, throttle and identity.
     * @return iterable<array{url:string,status:int,body:string,fetchedAt:\DateTimeImmutable}>
     */
    public function crawl(string $approvedTargetKey, iterable $urls): iterable;
}
