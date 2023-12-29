export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export interface Database {
  graphql_public: {
    Tables: {
      [_ in never]: never
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      graphql: {
        Args: {
          operationName?: string
          query?: string
          variables?: Json
          extensions?: Json
        }
        Returns: Json
      }
    }
    Enums: {
      [_ in never]: never
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
  public: {
    Tables: {
      Auction: {
        Row: {
          auction_type: Database["public"]["Enums"]["auction_types"]
          auctioneer_id: string
          created_at: string
          current_price: number
          deleted_at: string | null
          description: string | null
          end_time: string | null
          grab_now_price: number | null
          id: string
          image: string | null
          minimum_bid_decrement: number | null
          name: string
          start_time: string
          starting_price: number
          status: Database["public"]["Enums"]["auction_status"] | null
          updated_at: string
        }
        Insert: {
          auction_type: Database["public"]["Enums"]["auction_types"]
          auctioneer_id: string
          created_at?: string
          current_price: number
          deleted_at?: string | null
          description?: string | null
          end_time?: string | null
          grab_now_price?: number | null
          id?: string
          image?: string | null
          minimum_bid_decrement?: number | null
          name: string
          start_time?: string
          starting_price: number
          status?: Database["public"]["Enums"]["auction_status"] | null
          updated_at?: string
        }
        Update: {
          auction_type?: Database["public"]["Enums"]["auction_types"]
          auctioneer_id?: string
          created_at?: string
          current_price?: number
          deleted_at?: string | null
          description?: string | null
          end_time?: string | null
          grab_now_price?: number | null
          id?: string
          image?: string | null
          minimum_bid_decrement?: number | null
          name?: string
          start_time?: string
          starting_price?: number
          status?: Database["public"]["Enums"]["auction_status"] | null
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "Auction_auctioneer_id_fkey"
            columns: ["auctioneer_id"]
            isOneToOne: false
            referencedRelation: "AuctionHausUsers"
            referencedColumns: ["id"]
          }
        ]
      }
      AuctionBidders: {
        Row: {
          auction_id: string
          bidder_id: string
        }
        Insert: {
          auction_id: string
          bidder_id: string
        }
        Update: {
          auction_id?: string
          bidder_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "AuctionBidders_auction_id_fkey"
            columns: ["auction_id"]
            isOneToOne: false
            referencedRelation: "Auction"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "AuctionBidders_bidder_id_fkey"
            columns: ["bidder_id"]
            isOneToOne: false
            referencedRelation: "AuctionHausUsers"
            referencedColumns: ["id"]
          }
        ]
      }
      AuctionHausUsers: {
        Row: {
          bio: string | null
          buyer_rating: number
          buyer_reviews: number
          created_at: string
          deleted_at: string | null
          first_name: string
          id: string
          Inactive_since: string | null
          last_name: string
          profile_picture: string | null
          seller_rating: number
          seller_reviews: number
          updated_at: string | null
          username: string
        }
        Insert: {
          bio?: string | null
          buyer_rating?: number
          buyer_reviews?: number
          created_at?: string
          deleted_at?: string | null
          first_name: string
          id: string
          Inactive_since?: string | null
          last_name: string
          profile_picture?: string | null
          seller_rating?: number
          seller_reviews?: number
          updated_at?: string | null
          username: string
        }
        Update: {
          bio?: string | null
          buyer_rating?: number
          buyer_reviews?: number
          created_at?: string
          deleted_at?: string | null
          first_name?: string
          id?: string
          Inactive_since?: string | null
          last_name?: string
          profile_picture?: string | null
          seller_rating?: number
          seller_reviews?: number
          updated_at?: string | null
          username?: string
        }
        Relationships: [
          {
            foreignKeyName: "AuctionHausUsers_id_fkey"
            columns: ["id"]
            isOneToOne: true
            referencedRelation: "users"
            referencedColumns: ["id"]
          }
        ]
      }
      AuctionWinners: {
        Row: {
          auction_id: string
          winner_id: string
        }
        Insert: {
          auction_id: string
          winner_id: string
        }
        Update: {
          auction_id?: string
          winner_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "AuctionWinners_auction_id_fkey"
            columns: ["auction_id"]
            isOneToOne: false
            referencedRelation: "Auction"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "AuctionWinners_winner_id_fkey"
            columns: ["winner_id"]
            isOneToOne: false
            referencedRelation: "AuctionHausUsers"
            referencedColumns: ["id"]
          }
        ]
      }
      Bid: {
        Row: {
          auction_id: string
          bid_amount: number
          bidder_id: string
          created_at: string
          id: string
          status: string
        }
        Insert: {
          auction_id: string
          bid_amount: number
          bidder_id: string
          created_at?: string
          id?: string
          status?: string
        }
        Update: {
          auction_id?: string
          bid_amount?: number
          bidder_id?: string
          created_at?: string
          id?: string
          status?: string
        }
        Relationships: [
          {
            foreignKeyName: "Bid_auction_id_fkey"
            columns: ["auction_id"]
            isOneToOne: false
            referencedRelation: "Auction"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "Bid_bidder_id_fkey"
            columns: ["bidder_id"]
            isOneToOne: false
            referencedRelation: "AuctionHausUsers"
            referencedColumns: ["id"]
          }
        ]
      }
      Notification: {
        Row: {
          auction_id: string | null
          content: string
          created_at: string
          id: string
          is_read: boolean
          recipient_id: string
        }
        Insert: {
          auction_id?: string | null
          content: string
          created_at?: string
          id?: string
          is_read: boolean
          recipient_id: string
        }
        Update: {
          auction_id?: string | null
          content?: string
          created_at?: string
          id?: string
          is_read?: boolean
          recipient_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "Notification_auction_id_fkey"
            columns: ["auction_id"]
            isOneToOne: false
            referencedRelation: "Auction"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "Notification_recipient_id_fkey"
            columns: ["recipient_id"]
            isOneToOne: false
            referencedRelation: "AuctionHausUsers"
            referencedColumns: ["id"]
          }
        ]
      }
      Review: {
        Row: {
          auction_id: string
          content: string | null
          created_at: string
          deleted_at: string | null
          id: number
          rating: number
          reviewee_id: string
          reviewer_id: string
          type: Database["public"]["Enums"]["review_type"]
          updated_at: string | null
        }
        Insert: {
          auction_id: string
          content?: string | null
          created_at?: string
          deleted_at?: string | null
          id?: number
          rating: number
          reviewee_id: string
          reviewer_id: string
          type: Database["public"]["Enums"]["review_type"]
          updated_at?: string | null
        }
        Update: {
          auction_id?: string
          content?: string | null
          created_at?: string
          deleted_at?: string | null
          id?: number
          rating?: number
          reviewee_id?: string
          reviewer_id?: string
          type?: Database["public"]["Enums"]["review_type"]
          updated_at?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "Review_auction_id_fkey"
            columns: ["auction_id"]
            isOneToOne: false
            referencedRelation: "Auction"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "Review_reviewee_id_fkey"
            columns: ["reviewee_id"]
            isOneToOne: false
            referencedRelation: "AuctionHausUsers"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "Review_reviewer_id_fkey"
            columns: ["reviewer_id"]
            isOneToOne: false
            referencedRelation: "AuctionHausUsers"
            referencedColumns: ["id"]
          }
        ]
      }
      UserAddress: {
        Row: {
          address_line1: string
          address_line2: string | null
          city: string
          country: string
          created_at: string
          deleted_at: string | null
          id: number
          postal_code: string
          state_or_province: string
          updated_at: string
          user_id: string
        }
        Insert: {
          address_line1: string
          address_line2?: string | null
          city: string
          country: string
          created_at?: string
          deleted_at?: string | null
          id?: number
          postal_code: string
          state_or_province: string
          updated_at: string
          user_id: string
        }
        Update: {
          address_line1?: string
          address_line2?: string | null
          city?: string
          country?: string
          created_at?: string
          deleted_at?: string | null
          id?: number
          postal_code?: string
          state_or_province?: string
          updated_at?: string
          user_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "UserAddress_user_id_fkey"
            columns: ["user_id"]
            isOneToOne: true
            referencedRelation: "AuctionHausUsers"
            referencedColumns: ["id"]
          }
        ]
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      [_ in never]: never
    }
    Enums: {
      auction_status: "Active" | "Pending" | "Completed"
      auction_types: "Early Bird" | "Auctioneers Choice" | "Budget Battle"
      review_type: "Auctineer" | "Contractor"
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
  storage: {
    Tables: {
      buckets: {
        Row: {
          allowed_mime_types: string[] | null
          avif_autodetection: boolean | null
          created_at: string | null
          file_size_limit: number | null
          id: string
          name: string
          owner: string | null
          owner_id: string | null
          public: boolean | null
          updated_at: string | null
        }
        Insert: {
          allowed_mime_types?: string[] | null
          avif_autodetection?: boolean | null
          created_at?: string | null
          file_size_limit?: number | null
          id: string
          name: string
          owner?: string | null
          owner_id?: string | null
          public?: boolean | null
          updated_at?: string | null
        }
        Update: {
          allowed_mime_types?: string[] | null
          avif_autodetection?: boolean | null
          created_at?: string | null
          file_size_limit?: number | null
          id?: string
          name?: string
          owner?: string | null
          owner_id?: string | null
          public?: boolean | null
          updated_at?: string | null
        }
        Relationships: []
      }
      migrations: {
        Row: {
          executed_at: string | null
          hash: string
          id: number
          name: string
        }
        Insert: {
          executed_at?: string | null
          hash: string
          id: number
          name: string
        }
        Update: {
          executed_at?: string | null
          hash?: string
          id?: number
          name?: string
        }
        Relationships: []
      }
      objects: {
        Row: {
          bucket_id: string | null
          created_at: string | null
          id: string
          last_accessed_at: string | null
          metadata: Json | null
          name: string | null
          owner: string | null
          owner_id: string | null
          path_tokens: string[] | null
          updated_at: string | null
          version: string | null
        }
        Insert: {
          bucket_id?: string | null
          created_at?: string | null
          id?: string
          last_accessed_at?: string | null
          metadata?: Json | null
          name?: string | null
          owner?: string | null
          owner_id?: string | null
          path_tokens?: string[] | null
          updated_at?: string | null
          version?: string | null
        }
        Update: {
          bucket_id?: string | null
          created_at?: string | null
          id?: string
          last_accessed_at?: string | null
          metadata?: Json | null
          name?: string | null
          owner?: string | null
          owner_id?: string | null
          path_tokens?: string[] | null
          updated_at?: string | null
          version?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "objects_bucketId_fkey"
            columns: ["bucket_id"]
            isOneToOne: false
            referencedRelation: "buckets"
            referencedColumns: ["id"]
          }
        ]
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      can_insert_object: {
        Args: {
          bucketid: string
          name: string
          owner: string
          metadata: Json
        }
        Returns: undefined
      }
      extension: {
        Args: {
          name: string
        }
        Returns: string
      }
      filename: {
        Args: {
          name: string
        }
        Returns: string
      }
      foldername: {
        Args: {
          name: string
        }
        Returns: unknown
      }
      get_size_by_bucket: {
        Args: Record<PropertyKey, never>
        Returns: {
          size: number
          bucket_id: string
        }[]
      }
      search: {
        Args: {
          prefix: string
          bucketname: string
          limits?: number
          levels?: number
          offsets?: number
          search?: string
          sortcolumn?: string
          sortorder?: string
        }
        Returns: {
          name: string
          id: string
          updated_at: string
          created_at: string
          last_accessed_at: string
          metadata: Json
        }[]
      }
    }
    Enums: {
      [_ in never]: never
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
}

export type Tables<
  PublicTableNameOrOptions extends
    | keyof (Database["public"]["Tables"] & Database["public"]["Views"])
    | { schema: keyof Database },
  TableName extends PublicTableNameOrOptions extends { schema: keyof Database }
    ? keyof (Database[PublicTableNameOrOptions["schema"]]["Tables"] &
        Database[PublicTableNameOrOptions["schema"]]["Views"])
    : never = never
> = PublicTableNameOrOptions extends { schema: keyof Database }
  ? (Database[PublicTableNameOrOptions["schema"]]["Tables"] &
      Database[PublicTableNameOrOptions["schema"]]["Views"])[TableName] extends {
      Row: infer R
    }
    ? R
    : never
  : PublicTableNameOrOptions extends keyof (Database["public"]["Tables"] &
      Database["public"]["Views"])
  ? (Database["public"]["Tables"] &
      Database["public"]["Views"])[PublicTableNameOrOptions] extends {
      Row: infer R
    }
    ? R
    : never
  : never

export type TablesInsert<
  PublicTableNameOrOptions extends
    | keyof Database["public"]["Tables"]
    | { schema: keyof Database },
  TableName extends PublicTableNameOrOptions extends { schema: keyof Database }
    ? keyof Database[PublicTableNameOrOptions["schema"]]["Tables"]
    : never = never
> = PublicTableNameOrOptions extends { schema: keyof Database }
  ? Database[PublicTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Insert: infer I
    }
    ? I
    : never
  : PublicTableNameOrOptions extends keyof Database["public"]["Tables"]
  ? Database["public"]["Tables"][PublicTableNameOrOptions] extends {
      Insert: infer I
    }
    ? I
    : never
  : never

export type TablesUpdate<
  PublicTableNameOrOptions extends
    | keyof Database["public"]["Tables"]
    | { schema: keyof Database },
  TableName extends PublicTableNameOrOptions extends { schema: keyof Database }
    ? keyof Database[PublicTableNameOrOptions["schema"]]["Tables"]
    : never = never
> = PublicTableNameOrOptions extends { schema: keyof Database }
  ? Database[PublicTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Update: infer U
    }
    ? U
    : never
  : PublicTableNameOrOptions extends keyof Database["public"]["Tables"]
  ? Database["public"]["Tables"][PublicTableNameOrOptions] extends {
      Update: infer U
    }
    ? U
    : never
  : never

export type Enums<
  PublicEnumNameOrOptions extends
    | keyof Database["public"]["Enums"]
    | { schema: keyof Database },
  EnumName extends PublicEnumNameOrOptions extends { schema: keyof Database }
    ? keyof Database[PublicEnumNameOrOptions["schema"]]["Enums"]
    : never = never
> = PublicEnumNameOrOptions extends { schema: keyof Database }
  ? Database[PublicEnumNameOrOptions["schema"]]["Enums"][EnumName]
  : PublicEnumNameOrOptions extends keyof Database["public"]["Enums"]
  ? Database["public"]["Enums"][PublicEnumNameOrOptions]
  : never

