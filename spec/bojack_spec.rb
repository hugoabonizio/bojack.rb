require 'spec_helper'

describe BoJack::Client do
  hostname = "127.0.0.1"
  port = 5000

  client = BoJack::Client.new(hostname, port)

  describe "ping" do
    it "returns pong" do
      expect(client.ping).to eq("pong\n")
    end
  end

  describe "set" do
    it "sets key with value" do
      expect(client.set("bo", "jack")).to eq("jack\n")
    end

    it "sets key with a list" do
      expect(client.set("list", "boo,foo,bar")).to eq("[\"boo\", \"foo\", \"bar\"]\n")
    end
  end

  describe "increment" do
    after do
      client.delete("counter")
    end

    describe "with valid params" do
      it "increments the key value by 1" do
        client.set("counter", "10")

        expect(client.increment("counter")).to eq("11\n")
      end
    end

    describe "with an invalid key" do
      describe "when the key does not exists" do
        it "raises proper error" do
          expect(client.increment("invalid_counter")).to eq("error: 'invalid_counter' is not a valid key\n")
        end
      end

      describe "when the key is an array" do
        it "raises proper error" do
          client.set("counter", "a,b,c")
          expect(client.increment("counter")).to eq("error: 'counter' cannot be incremented\n")
        end
      end

      describe "when the key is a string" do
        it "raises proper error" do
          client.set("counter", "a")
          expect(client.increment("counter")).to eq("error: 'counter' cannot be incremented\n")
        end
      end
    end
  end

  describe "get" do
    context "with a valid key" do
      it "returns the key value" do
        expect(client.get("bo")).to eq("jack\n")
      end

      it "returns a list" do
        expect(client.get("list")).to eq("[\"boo\", \"foo\", \"bar\"]\n")
      end
    end

    context "with an invalid key" do
      it "returns proper error message" do
        expect(client.get("love")).to eq("error: 'love' is not a valid key\n")
      end
    end
  end

  describe "append" do
    context "with a valid key" do
      it "returns the key value" do
        client.set("list", "boo,foo,bar")
        expect(client.append("list", "lol")).to eq("[\"boo\", \"foo\", \"bar\", \"lol\"]\n")

        client.delete("list")
      end
    end

    context "with an invalid key" do
      it "returns proper error message" do
        expect(client.append("bar", "lol")).to eq("error: 'bar' is not a valid key\n")
      end
    end
  end

  describe "pop" do
    context "with a valid key" do
      it "returns the key value" do
        client.set("list", "boo,foo,bar")
        expect(client.pop("list")).to eq("bar\n")

        client.delete("list")
      end
    end

    context "with an invalid key" do
      it "returns proper error message" do
        expect(client.append("bar", "lol")).to eq("error: 'bar' is not a valid key\n")
      end
    end
  end

  describe "delete" do
    context "with a valid key" do
      it "returns the key value" do
        expect(client.delete("bo")).to eq("jack\n")
      end
    end

    context "with an invalid key" do
      it "returns proper error message" do
        expect(client.delete("bar")).to eq("error: 'bar' is not a valid key\n")
      end
    end
  end

  describe "size" do
    it "returns the size of the store" do
      client.set("bo", "jack")
      expect(client.size).to eq("1\n")
    end
  end
end
