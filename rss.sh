# RSS header
echo '<?xml version="1.0" encoding="UTF-8" ?>'
echo '<rss version="2.0">'
echo '<channel>'
echo '    <title>Notes of Nishi</title>'
echo '    <link>https://shaiyaj.github.io</link>'
echo '    <description>Collection of random things that I work on and do in my free time. Mostly Computer Science related.</description>'


# Generating an rss feed

find ./notes/content -type f | while read -r path; do
    ts=$(git log --diff-filter=A --format="%ct" -- "$path")
    echo "$ts $path"
done | sort -nr | while read -r ts path; do
    echo '    <item>'
    echo "        <title>${path##*/}</title>"
    echo "        <link>https://shaiyaj.github.io/notes/?$(echo "${path#./notes/content/}" | tr '/' ':' | sed 's/ /%20/g')</link>"
    echo "        <description>${path##*/}, a post by Nishi (found at ${path})</description>"
    echo "        <pubDate>$(date -d "@$ts" -R)</pubDate>"
    echo '    </item>'
done   

# RSS footer

echo '</channel>'
echo '</rss>'
