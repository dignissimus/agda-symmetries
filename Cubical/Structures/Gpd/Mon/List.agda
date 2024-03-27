{-# OPTIONS --cubical --exact-split #-}
module Cubical.Structures.Gpd.Mon.List where

open import Cubical.Foundations.Everything hiding (str)
open import Cubical.Data.Sigma
open import Cubical.Data.List
open import Cubical.Data.Nat
open import Cubical.Data.Nat.Order
import Cubical.Data.Empty as ⊥
open import Cubical.Functions.Logic as L

import Cubical.Structures.Set.Mon.Desc as M
import Cubical.Structures.Free as F
open import Cubical.Structures.Sig
open import Cubical.Structures.Str public hiding (struct ; car)
open import Cubical.Structures.Tree
open import Cubical.Structures.Eq
open import Cubical.Structures.Arity
open import Cubical.HITs.PropositionalTruncation as P

open import Cubical.Structures.Prelude
import Cubical.Structures.Set.Mon.List as L
open import Cubical.Structures.Gpd.Mon.Desc as L

private
  variable
    ℓ : Level
    A : Type ℓ

list-α : sig M.MonSig (List A) -> List A
list-α = L.list-α

private
  list-▿ : (xs ys : List A)
         → ++-assoc xs [] ys ∙ ap (xs ++_) (idp ys)
          ≡ ap (_++ ys) (++-unit-r xs)
  list-▿ [] ys =
      ++-assoc [] [] ys ∙ ap ([] ++_) (idp ys)
    ≡⟨⟩
      refl ∙ refl
    ≡⟨ sym (lUnit refl) ⟩
      refl
    ≡⟨⟩
      ap (_++ ys) (++-unit-r [])
    ∎
  list-▿ (x ∷ xs) ys =
      ++-assoc (x ∷ xs) [] ys ∙ ap ((x ∷ xs) ++_) (idp ys)
    ≡⟨⟩
      ap (x ∷_) (++-assoc xs [] ys) ∙ idp (x ∷ xs ++ ys)
    ≡⟨ sym (rUnit (ap (x ∷_) (++-assoc xs [] ys))) ⟩
      ap (x ∷_) (++-assoc xs [] ys)
    ≡⟨ ap (ap (x ∷_)) (rUnit (++-assoc xs [] ys)) ⟩
      ap (x ∷_) (++-assoc xs [] ys ∙ ap (xs ++_) (idp ys))
    ≡⟨ ap (ap (x ∷_)) (list-▿ xs ys) ⟩
      ap (x ∷_) (ap (_++ ys) (++-unit-r xs))
    ≡⟨⟩
      ap (_++ ys) (ap (x ∷_) (++-unit-r xs))
    ≡⟨⟩
      ap (_++ ys) (++-unit-r (x ∷ xs))
    ∎

list-str : MonStr (List A)
𝟙 list-str = []
_⊗_ list-str = _++_
Λ list-str = idp
ρ list-str = ++-unit-r
α list-str = ++-assoc
▿ list-str = list-▿
⬠ list-str [] [] [] [] = refl
⬠ list-str [] [] [] (x ∷ w) =
    α list-str ((list-str ⊗ (x ∷ w)) []) [] [] ∙ α list-str (x ∷ w) [] ((list-str ⊗ []) [])
  ≡⟨⟩
    α list-str ((list-str ⊗ (x ∷ w)) []) [] [] ∙ α list-str (x ∷ w) [] []
  ≡⟨⟩
    ++-assoc ((_++_ (x ∷ w)) []) [] [] ∙ ++-assoc (x ∷ w) [] []
  ≡⟨⟩
    ++-assoc ((x ∷ w) ++ []) [] [] ∙ ++-assoc (x ∷ w) [] []
  ≡⟨ {!!} ⟩
    (ap (λ left → left ++ []) (++-assoc (x ∷ w) [] [])) ∙ ++-assoc (x ∷ w) [] []
  ≡⟨ {! refl!} ⟩
  ap (λ section₁ → section₁ ++ [])
    (++-assoc (x ∷ w) [] [])
    ∙ ++-assoc (x ∷ w) [] [] ∙  ap (_++_ (x ∷ w)) (++-assoc [] [] [])
  ≡⟨⟩
    ap (λ section₁ → (_++_ section₁) [])
    (++-assoc (x ∷ w) [] [])
    ∙ ++-assoc (x ∷ w) [] [] ∙  ap (_++_ (x ∷ w)) (++-assoc [] [] [])
  ≡⟨⟩
    ap (λ section₁ → (_++_ section₁) [])
    (++-assoc (x ∷ w) [] [])
    ∙ ++-assoc (x ∷ w) ((_++_ []) []) [] ∙  ap (_++_ (x ∷ w)) (++-assoc [] [] [])
  ≡⟨⟩
    ap (λ section₁ → (list-str ⊗ section₁) [])
    (α list-str (x ∷ w) [] [])
    ∙ α list-str (x ∷ w) ((list-str ⊗ []) []) [] ∙  ap (list-str ⊗ (x ∷ w)) (α list-str [] [] [])
   ∎

⬠ list-str [] [] (x ∷ z) [] = {!!}
⬠ list-str [] [] (x ∷ z) (x₁ ∷ w) = {!!}
⬠ list-str [] (x ∷ y) [] [] = {!!}
⬠ list-str [] (x ∷ y) [] (x₁ ∷ w) = {!!}
⬠ list-str [] (x ∷ y) (x₁ ∷ z) [] = {!!}
⬠ list-str [] (x ∷ y) (x₁ ∷ z) (x₂ ∷ w) = {!!}
⬠ list-str (x ∷ x₁) [] [] [] = {!!}
⬠ list-str (x ∷ x₁) [] [] (x₂ ∷ w) = {!!}
⬠ list-str (x ∷ x₁) [] (x₂ ∷ z) [] = {!!}
⬠ list-str (x ∷ x₁) [] (x₂ ∷ z) (x₃ ∷ w) = {!!}
⬠ list-str (x ∷ x₁) (x₂ ∷ y) [] [] = {!!}
⬠ list-str (x ∷ x₁) (x₂ ∷ y) [] (x₃ ∷ w) = {!!}
⬠ list-str (x ∷ x₁) (x₂ ∷ y) (x₃ ∷ z) [] = {!!}
⬠ list-str (x ∷ x₁) (x₂ ∷ y) (x₃ ∷ z) (x₄ ∷ w) = {!!}

module Free {x y : Level} {A : Type x} (𝔜 : MonGpd y) where

  module _ (f : A -> 𝔜 .car) where
    _♯ : List A -> 𝔜 .car
    [] ♯ = 𝔜 .str .𝟙
    (x ∷ xs) ♯ = 𝔜 .str ._⊗_ (f x) (xs ♯)
