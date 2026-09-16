#lang racket

(require xml)
(require "../../components.rkt")

(page-template "ShaiyaJ::Recommended" 
            `(  (h1 "Blog recommendations")
                (p "A lot of the blogs that I read have a post/page dedicated to linking to other blogs. These are usually their friends or just blogs that they themselves read.")
                (p "I've always approved of this sort of thing, I've managed to find some great blogs because other people take the time to lay out their recommendations in this way. This sort of linking, a \"web\" if you will, is a product of a bygone era of the internet in many ways.")
                (p "I'd like to take some time to link to some thought-provoking blogs that I read:")
                (ul (li (a ((href "https://mcyoung.xyz")) "Sunny") " - Great posts that go in-depth on compiler development and low level programming")
                    (li (a ((href "https://wolfgirl.dev")) "PolyWolf") " - Nice collection of cybersecurity reads and a range of programming posts covering both high and low level topics"))
                (p "I don't know any of these people personally, these are just the good reads that I've come across.")
                (p "I also don't guarantee that these links are necessarily safe. I read a lot of these posts through a feed reader so if the sites have been compromised then I probably wouldn't realise. Browse safely!")))
