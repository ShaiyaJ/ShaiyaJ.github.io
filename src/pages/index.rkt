#lang racket

(require xml)
(require "../components.rkt")

(page-template "ShaiyaJ" 
            `(  (h1 "Shaiya J.")
                (p "I'm a hobbyist programmer who dabbles in both high and low level programming. I intend for this website to complement my Github, allowing me to showcase projects and go into detail on things that I otherwise wouldn't be able to in a simple README.")
                (p "A lot of projects are avaliable on my " (a ((href "https://github.com/ShaiyaJ")) "Github") " and are open-source - usually under the MPL or MIT license. I make most of my projects out of enjoyment, usually to solve real world problems that I'm having or to experiment with a random idea.")
                (p "I also intend my " (a ((href "/blog")) "blog") " to become a way to add commentary to my projects and any other hobbies of mine.")))
