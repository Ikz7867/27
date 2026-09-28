<?php
declare(strict_types=1);

namespace PriceComp\Contracts;

interface CartExporter
{
    /** Cart format is selected only after the named target is recovered from SPEC. */
    public function cartKey(): string;

    /**
     * Stream escaped/validated export chunks; do not embed credentials.
     * @param iterable<array{productId:int,title:string,url:string,price:Money}> $products
     * @param array<string,scalar|null> $options
     * @return iterable<string>
     */
    public function export(iterable $products, array $options): iterable;
}
