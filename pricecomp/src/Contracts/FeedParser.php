<?php
declare(strict_types=1);

namespace PriceComp\Contracts;

interface FeedParser
{
    /**
     * Stream CSV, TSV or XML with bounded memory. Parser validates format and rejects XML external entities.
     * @param resource $stream Already-opened, approved local/download stream.
     * @param array<string,string> $fieldMap Canonical field => source field/path.
     * @return iterable<array{rowNumber:int,fields:array<string,scalar|null>,errors:list<string>}>
     */
    public function parse($stream, string $format, array $fieldMap): iterable;
}
