{
    outputs = _: {
        overlays.default = final: _prev: import ./packages final;
    };
}
