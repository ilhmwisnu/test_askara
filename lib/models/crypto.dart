class Crypto {
    final String? s;
    final String? p;
    final String? q;
    final String? dc;
    final String? dd;
    final int? t;

    Crypto({
        this.s,
        this.p,
        this.q,
        this.dc,
        this.dd,
        this.t,
    });

    factory Crypto.fromJson(Map<String, dynamic> json) => Crypto(
        s: json["s"],
        p: json["p"],
        q: json["q"],
        dc: json["dc"],
        dd: json["dd"],
        t: json["t"],
    );

    Map<String, dynamic> toJson() => {
        "s": s,
        "p": p,
        "q": q,
        "dc": dc,
        "dd": dd,
        "t": t,
    };
}
