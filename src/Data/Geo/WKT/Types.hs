{-# LANGUAGE TemplateHaskell #-}

module Data.Geo.WKT.Types where

import Control.Lens
import Linear

-- ^ From http://www.geoapi.org/3.0/javadoc/org/opengis/referencing/doc-files/WKT.html

data Parameter = Parameter { _paramName     :: String
                           , _paramValue    :: Double
                           }
makeLenses ''Parameter

data Authority = Authority { _authorityName :: String
                           , _authorityCode :: String
                           }
makeLenses ''Authority

data Unit = Unit { _unitName               :: String
                 , _unitConversionFactor   :: Double
                 , _unitAuthority          :: Maybe Authority
                 }
makeLenses ''Unit

data Spheroid = Spheroid { _spheroidName                :: String
                         , _spheroidSemiMajor           :: Double
                         , _spheroidInverseFlattening   :: Double
                         , _spheroidAuthority           :: Maybe Authority
                         }
makeLenses ''Spheroid

data ToWGS84 = ToWGS84 { _towgs84D      :: V3 Double
                       , _towgs84E      :: V3 Double
                       , _towgs84PPM    :: Double
                       }
makeLenses ''ToWGS84

data Datum = Datum { _datumName         :: String
                   , _datumSpheroid     :: Spheroid
                   , _datumToWGS84      :: Maybe ToWGS84
                   , _datumAuthority    :: Maybe Authority
                   }
makeLenses ''Datum

data PrimeMeridian = PrimeMeridian { _primemName      :: String
                                   , _primemLongitude :: Double
                                   , _primemAuthority :: Maybe Authority
                                   }
makeLenses ''PrimeMeridian     

data AxisDirection = North | South | East | West | Up | Down | Other

data Axis = Axis { _axisName      :: String
                 , _axisDirection :: AxisDirection
                 }
makeLenses ''Axis     

data GeographicCS = GeogCS { _geogcsName            :: String
                           , _geogcsDatum           :: Datum
                           , _geogcsPrimeMeridian   :: PrimeMeridian
                           , _geogcsAngularUnit     :: Unit
                           , _geogcsTwinAxes        :: Maybe (Axis, Axis)
                           , _geogcsAuthority       :: Maybe Authority
                           }
makeLenses ''GeographicCS

data Projection = Proj { _projName         :: String
                       , _projAuthority    :: Maybe Authority
                       }
makeLenses ''Projection

data ProjectedCS = ProjCS { _projcsName             :: String
                          , _projcsGeographicCS     :: GeographicCS
                          , _projcsProjection       :: Projection
                          , _projcsParameters       :: [Parameter]
                          , _projcsLinearUnit       :: Unit
                          , _projcsTwinAxes         :: Maybe (Axis, Axis)
                          , _projcsAuthority        :: Maybe Authority
                          }
