DROP TABLE IF EXISTS secret_gifts;

CREATE TABLE secret_gifts (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  code TEXT UNIQUE NOT NULL,
  amount NUMERIC NOT NULL,
  sender TEXT NOT NULL,
  sender_name TEXT DEFAULT '',
  recipient TEXT DEFAULT '',
  message TEXT DEFAULT '',
  image_url TEXT DEFAULT '',
  encrypted_pk TEXT DEFAULT '',
  claimed BOOLEAN DEFAULT false,
  claimed_by TEXT DEFAULT '',
  claimed_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT now()
);

ALTER TABLE secret_gifts ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow all" ON secret_gifts FOR ALL USING (true) WITH CHECK (true);
