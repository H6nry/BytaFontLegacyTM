# BytaFontLegacyTM
A Tweak Mode for old iOS versions which are not supported by BytaFont2 and BytaFontTM (aka BytaFont Tweak Mode).
You will not need any of BytaFont, BytaFont2, or BytaFontTM installed in order to use this. I managed to do
some "control" magic to satisfy Cydia (dpkg) with the dependencies and let you install Fonts for Tweak Mode
without even having installed it ;P.

There is much room for improvements here, you could, for example, hook even deeper into iOS
and replace fonts in CoreGraphics framework. This would also resolve version incompatibilities...

I think font theming is a quite cool thing but the problem i had with it was that BytaFont
(the only big font provider) REPLACED SYSTEM FILES. I personally do not like it when things replace anthing
so i never themed my fonts. Then i saw BytaFont Tweak Mode coming up in Cydia which only supported BytaFont2
and so only iOS 7+. I only have an iPhone 4 with iOS 6 atm so i could, again, not theme my fonts :(.
Because iOS 6 is quite ancient for now, i knew that the BytaBont team would never release a tweak
mode for BytaFont 1. So i just wrote it myself within a week or two (i am really sloow :D) and
it does its job quite well and seamless.
If you think this should come up in Cydia store, please organize some testing devices for me
so we can test BFLTM very well first (as mentioned above the hooks i use are quite unstable regarding
different iOS versions...) or you just wait until i am motivated enough to implement a stable soultion
by myself (which maybe never happens, because it is 100% stable for me). Also the demand, it think, is
much too small to release on Cydia.

I published this because it is my first MS-hook tweak and it shows quite good how to hook deeper
into iOS with MobileSubstrate than Logos could ever do. So if you learned cool things from this,
say "Thank you" to me: henry.anonym@gmail.com :)

License:
Do what you want with it, just email me if you are going to publish parts of this.
I also would like to be mentioned in the source code, if published in source code form,
and credited, if published only in binary form.
Due to the informality of this license, you are allowed to ignore this if you want to.
