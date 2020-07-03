#!/bin/bash

~/github/topobyte/osm4j/extra/scripts/OsmBuildExtractionFiles --input-format pbf \
	--input ~/Downloads/brandenburg-latest.osm.pbf --output brandenburg \
	--max-nodes 100000 --max-members-simple 10000 --max-members-complex 10000
