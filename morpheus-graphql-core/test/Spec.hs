{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE NoImplicitPrelude #-}

module Main
  ( main,
  )
where

import Relude
import Test.Tasty
  ( defaultMain,
    testGroup,
  )
import Utils.Api
  ( apiTest,
  )
import qualified Utils.MergeSchema as MergeSchema
import qualified Utils.Rendering as Rendering
import Utils.Schema
  ( testSchema,
  )

main :: IO ()
main = do
  schema <- testSchema
  mergeSchema <- MergeSchema.test
  defaultMain $
    testGroup
      "core tests"
      [ schema,
        mergeSchema,
        apiTest "api/deity" ["simple", "interface"],
        apiTest
          "api/validation/fragment"
          [ "on-type",
            "on-interface",
            "on-interface-inline",
            "on-union-type",
            "fail-unknown-field-on-interface",
            "on-interface-type-casting",
            "on-interface-type-casting-inline",
            "on-interface-fail-without-casting"
          ],
        Rendering.test
          "rendering/simple"
          [ "simple",
            "nested",
            "query",
            "mutation",
            "subscription",
            "directive"
          ],
        Rendering.test
          "rendering/union"
          [ "interface",
            "union"
          ],
        Rendering.test
          "rendering/variable"
          [ "simple",
            "input",
            "enum",
            "list",
            "include-exclude"
          ]
      ]
