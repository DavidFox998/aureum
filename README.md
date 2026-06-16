# aureum — Morning Star Project

**Lean 4 proof tower for the Morning Star research programme.**

Yang-Mills lives separately at [yang-mills-gap](https://github.com/DavidFox998/yang-mills-gap).
This repo contains: **Riemann Hypothesis · Birch & Swinnerton-Dyer · BDP · Hodge · Protocol**.

## Tower structure

```
aureum/
├── lakefile.lean              # Mathlib v4.12.0 pinned by SHA
├── lean-toolchain             # leanprover/lean4:v4.12.0
├── Towers/
│   ├── RH/                    # Riemann Hypothesis (C01–C14 chain)
│   │   ├── Chain/             # C01_Arakelov → C14_BC6SpectralGap
│   │   ├── Formalized/        # Module-level bricks
│   │   ├── IwaniecKowalski/
│   │   ├── KimSarnak/
│   │   └── ConverseTheorem/
│   ├── BSD/                   # Birch & Swinnerton-Dyer (J₀(143))
│   ├── BDP/                   # Big Dipper Phase Reversal
│   ├── Hodge/                 # Hodge Conjecture (abelian surface)
│   └── Protocol/              # MorningStar · SuperBric protocol
├── Seal/                      # Axiom + sorry audit
└── README.md
```

## Axiom invariant

All landed bricks: **`{propext, Classical.choice, Quot.sound}`** only — no `sorry`, no `admit`.

## Verify

```bash
git clone https://github.com/DavidFox998/aureum
cd aureum
lake exe cache get
lake build
```

## Related repos

| Repo | Purpose |
|------|---------|
| [yang-mills-gap](https://github.com/DavidFox998/yang-mills-gap) | Yang-Mills & Mass Gap tower |
| [pistus-theoria](https://github.com/DavidFox998/pistus-theoria) | LaTeX source for all MS documents |
| [pistus-sophia](https://github.com/DavidFox998/pistus-sophia) | PDF library & referee portal |
