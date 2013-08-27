# Spinamp
## It really whips the moose's ass

Spinamp was my hack for the [Music Hack Day San Francisco 2012][mhd]

Spinamp is a full-featured, skinnable WinAmp clone that runs inside Spotify.
It's got a working spectrogram and custom visualization, and even the buttons
work.

![Spinamp](http://wiki.musichackday.org/images/5/5f/Spinamp.png)

Thanks to [Daniel Kennett][dan] for providing me with a special build.
The visualization code is based on [this JS1K demo by Steven Wittens][demo].

**Attention:** Spinamp requires custom events currently not available in any
public version of Spotify, which means _it will probably not work_ for you.

I hope Spotify adds this functionality to the production version soon, and I
hope I can extract the visualization code into its own app.

[mhd]:  http://sf.musichackday.org/2012/
[dan]:  https://github.com/iKenndac
[demo]: http://acko.net/blog/js1k-demo-the-making-of/
